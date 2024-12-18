local path_helpers = require 'LazyLanguages.helpers.paths'
local vim_helpers = require 'LazyLanguages.helpers.vim'
local M = {}

---@class ll.Config
local config = {
  mason = {
    ---Are mason packages for languages automatically installed
    ---@type boolean
    automatic_install = false,

    ---Are mason packages for languages automatically updated
    ---@type boolean
    automatic_update = false,
  },

  formatting = {
    ---Which formatting plugin is used.
    ---@type "conform"
    plugin = 'conform', -- https://github.com/stevearc/conform.nvim
  },

  --TODO: Implement
  linting = {
    ---Which linting plugin is used
    ---@type "nvim-lint"
    plugin = 'nvim-lint', -- https://github.com/mfussenegger/nvim-lint
  },

  completion = {
    ---Which completion plugin is used for the default capabilities and any other completion sensitive things
    ---@type "nvim-cmp"|"blink.cmp"
    plugin = 'nvim-cmp',
  },

  lsp = {
    ---The lsp on attach function to be forwarded to lspconfig
    ---@param client vim.lsp.Client
    ---@param bufnr number
    on_attach = function(client, bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end,

    ---Default LSP client capabilities. May be extended/modified via individual language configs.
    ---Capabilities are merged when setting up the language server. So you only need to put overrides in language specific configs.
    ---The default value is generated based on the completion plugin you use.
    ---@type lsp.ClientCapabilities
    capabilities = nil,

    ---Flags for controlling the behavior of lsps
    ---@type table
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
    },
  },
}

---@param opts? ll.Config
M.setup = function(opts)
  opts = opts or {}
  config = vim.tbl_deep_extend('keep', opts, config)

  if config.lsp.capabilities == nil then
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if config.completion.plugin == 'nvim-cmp' then
      local cmp_lsp = require 'cmp_nvim_lsp'
      config.lsp.capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
    elseif config.completion.plugin == 'blink.cmp' then
      config.lsp.capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    end
  end

  require('LazyLanguages.langs').language_setup()

  vim.api.nvim_create_autocmd('UIEnter', {
    group = vim.api.nvim_create_augroup('LLMasonInstall', { clear = true }),
    once = true,
    callback = function()
      if config.mason.automatic_update then
        vim.cmd 'LLMasonUpdate'
      end

      if config.mason.automatic_install then
        vim.cmd 'LLMasonInstall'
      end
    end,
  })

  vim.api.nvim_create_user_command('LLCreateOverride', function(options)
    if type(vim.g.lazylangs.override_path) ~= 'string' then
      vim_helpers.notify("'vim.g.lazylangs.override_path' must be declared in order to dump the existing config", vim.log.levels.ERROR)
      return
    end
    local language = string.lower(options.args)
    local success, _ = pcall(require, 'LazyLanguages.languages.' .. language)
    if not success then
      vim_helpers.notify(string.format("'%s' is not a language supported by LazyLanguages", language), vim.log.levels.WARN)
      return
    end
    local plugin_path = nil
    for _, plugin in ipairs(require('lazy').plugins()) do
      if plugin.name == 'LazyLanguages.nvim' then
        plugin_path = plugin.dir
      end
    end

    if plugin_path == nil then
      vim_helpers.notify('Could not find the plugin directory for LazyLanguages.nvim', vim.log.levels.ERROR)
      return
    end

    local file_path = plugin_path .. ('/lua/LazyLanguages/languages/'):gsub('/', path_helpers.path_separator) .. language .. '.lua'
    local file_handle = io.open(file_path, 'r')
    if file_handle == nil then
      vim_helpers.notify(string.format("There was an error opening the file for '%s'", language), vim.log.levels.ERROR)
      return
    end
    local file_content = file_handle:read '*a'
    file_handle:close()

    local override_path = vim.fn.stdpath 'config'
      .. path_helpers.path_separator
      .. 'lua'
      .. path_helpers.path_separator
      .. vim.g.lazylangs.override_path:gsub('%.', path_helpers.path_separator)

    if not vim.uv.fs_stat(override_path) then
      if not vim.fn.mkdir(override_path, 'p') then
        vim_helpers.notify(string.format("There was an error creating directory '%s'", override_path), vim.log.levels.ERROR)
        return
      end
    end
    local dump_file_path = override_path .. path_helpers.path_separator .. language .. '.lua'
    if vim.uv.fs_stat(dump_file_path) then
      if vim.fn.confirm(dump_file_path .. ' already exists, do you want to override it?', '&Yes\n&No', 2, 'Question') ~= 1 then
        vim_helpers.notify 'Aborting config dump'
        return
      end
    end
    local dump_file = io.open(dump_file_path, 'w')
    if dump_file == nil then
      vim_helpers.notify(string.format("There was an error opening '%s' to write out the config", dump_file_path), vim.log.levels.ERROR)
      return
    end
    dump_file:write(file_content)
    dump_file:close()
  end, {
    nargs = 1,
    complete = function(argLead, _, _)
      local plugin_path = nil
      for _, plugin in ipairs(require('lazy').plugins()) do
        if plugin.name == 'LazyLanguages.nvim' then
          plugin_path = plugin.dir
        end
      end

      if plugin_path == nil then
        vim_helpers.notify('Could not find the plugin directory for LazyLanguages.nvim', vim.log.levels.ERROR)
        return
      end

      local language_list = {}
      local language_dir = plugin_path .. ('/lua/LazyLanguages/languages'):gsub('/', path_helpers.path_separator)
      for name, _ in vim.fs.dir(language_dir, opts) do
        local wordstart, wordend = string.find(name, '%w+%.')
        if wordstart == nil then
          goto continue
        end
        local language_name = string.sub(name, wordstart, wordend - 1)
        wordstart, wordend = string.find(language_name, argLead)
        if wordstart ~= nil then
          table.insert(language_list, language_name)
        end

        ::continue::
      end
      return language_list
    end,
  })
end

return setmetatable(M, {
  __index = function(_, k)
    return config[k]
  end,
})

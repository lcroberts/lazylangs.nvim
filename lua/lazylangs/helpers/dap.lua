local M = {}

M.codelldb_adapter_config = {
  type = 'server',
  port = '${port}',
  executable = {
    command = require('lazylangs.helpers.paths').mason_bin_path 'codelldb',
    args = { '--port', '${port}' },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

---Returns a simple configuration that is compatible with codelldb
---@param adapter string
---@return table
M.simple_codelldb_launch_config = function(adapter)
  return {
    {
      name = 'Launch file',
      type = adapter,
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      args = function()
        local args_string = vim.fn.input 'Arguments: '
        return vim.split(args_string, ' ')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }
end

return M

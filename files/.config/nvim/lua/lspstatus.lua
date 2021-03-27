-- Credit: https://github.com/nvim-lua/lsp-status.nvim/blob/master/lua/lsp-status.lua
local diagnostics = require('lsp-status/diagnostics')
local messaging = require('lsp-status/messaging')
local current_function = require('lsp-status/current_function')
local statusline = require('lsp-status/statusline')

--@param config: (required, table) Table of values; keys are as listed above. Accept defaults by
--- omitting the relevant key.
local function config(user_config)
  _config = vim.tbl_extend('keep', user_config, _config, default_config)

  messaging._init(messages, _config)
  current_function._init(messages, _config)
  statusline._init(messages, _config)
end

--- Register a new server for messages.
--- Use this function either as your server's `on_attach` or inside your server's `on_attach`. It
--- registers the server with `lsp-status` for progress message handling and current function
--- updating
---
--@param client: (required, vim.lsp.client)
local function on_attach(client)
  -- Register the client for messages
  messaging.register_client(client.id, client.name)

  -- Set up autocommands to refresh the statusline when information changes
  vim.api.nvim_command('augroup lsp_aucmds')
  vim.api.nvim_command('au! * <buffer>')
  vim.api.nvim_command('au User LspDiagnosticsChanged redrawstatus!')
  vim.api.nvim_command('au User LspMessageUpdate redrawstatus!')
  vim.api.nvim_command('au User LspStatusUpdate redrawstatus!')
  vim.api.nvim_command('augroup END')

  -- If the client is a documentSymbolProvider, set up an autocommand
  -- to update the containing symbol
  if client.resolved_capabilities.document_symbol then
    vim.api.nvim_command('augroup lsp_aucmds')
    vim.api.nvim_command(
      'au CursorHold <buffer> lua require("lsp-status").update_current_function()'
    )
    vim.api.nvim_command('augroup END')
  end
end

--- Return the current set of messages from all servers. Messages are either progress messages,
--- file status messages, or "normal" messages.
--- Progress messages are tables of the form
--- `{
---      name = Server name,
---      title = Progress item title,
---      message = Current progress message (if any),
---      percentage = Current progress percentage (if any),
---      progress = true,
---      spinner = Spinner frames index,
---    }`
---
--- File status messages are tables of the form
--- `{
---      name = Server name,
---      content = Message content,
---      uri = File URI,
---      status = true
---    }`
--- Normal messages are tables of the form
--- `{ name = Server name, content = Message contents }`
---
--@returns list of messages
local function messages() -- luacheck: no unused
  error()
end

--- Register the progress callback with Neovim's LSP client.
--- Call once before starting any servers
local function register_progress() -- luacheck: no unused
  error()
end

local function status()
  return 'hello'
end

local M = {
  register_progress = messaging.register_progress,
  register_client = messaging.register_client,
  config = config,
  on_attach = on_attach,
  status = status,
}

return M

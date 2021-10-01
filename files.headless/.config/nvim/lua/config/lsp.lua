local nvim_lsp = require("lspconfig")
local map = vim.api.nvim_set_keymap
local option = vim.api.nvim_set_option

-- Enable completion triggered by <c-x><c-o>
option("omnifunc", "v:lua.vim.lsp.omnifunc")

-- Mappings.
local opts = {noremap = true, silent = true}

-- See `:help vim.lsp.*` for documentation on any of the below functions
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
map("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

local g = vim.g

-- https://github.com/ms-jpq/coq_nvim#autostart-coq
g.coq_settings = {
  ["auto_start"] = "shut-up",
  ["display.icons.mode"] = "long",
  ["display.ghost_text.context"] = {"[", "]"},
  ["display.pum.source_context"] = {"[", "]"},
  ["match.exact_matches"] = 5,
  ["weights.prefix_matches"] = 3.0
}

require("coq")

local servers = {"rust_analyzer", "gopls", "bashls", "dockerls", "terraformls", "tflint", "yamlls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach
  }
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities())
end

-- https://github.com/nvim-lua/diagnostic-nvim
g.diagnostic_enable_virtual_text = 0
g.diagnostic_virtual_text_prefix = "■"
g.diagnostic_trimmed_virtual_text = "30"
g.space_before_virtual_text = 10
g.diagnostic_show_sign = 1
g.diagnostic_enable_underline = 0
g.diagnostic_auto_popup_while_jump = 0
g.diagnostic_insert_delay = 1

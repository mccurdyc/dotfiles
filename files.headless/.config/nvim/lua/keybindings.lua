local map = vim.api.nvim_set_keymap
local opts = {noremap = true}

-- {{ General
vim.g.maplocalleader = ","
vim.g.mapleader = ","

-- Paste more than once.
map("x", "p", "pgvy", opts)

-- Clear search highlights.
map("n", "<Leader>cs", ":nohls<CR>", opts)

-- Tab movement.
map("n", "<c-Left>", "<cmd>tabpre<cr>", opts)
map("n", "<c-Right>", "<cmd>tabnext<cr>", opts)

-- }}

-- Telescope
map("n", "<leader>f", ":Telescope live_grep<CR>", opts)
map("n", "<C-p>", ':lua require("telescope.builtin").git_files()<CR>', opts)
map("n", "<leader>gs", ":Telescope git_files<CR>", opts)

-- Completion
map("i", "<tab>", "<Plug>(completion_smart_tab)", opts)
map("i", "<s-tab>", "<Plug>(completion_smart_s_tab)", opts)

-- ALE
map("n", "<silent> <C-k>", "<Plug>(ale_previous)", opts)
map("n", "<silent> <C-j>", "<Plug>(ale_next)", opts)
map("n", "<leader>rn", ":ALERename<CR>", opts)
map("n", "<leader>ss", ":ALESymbolSearch", opts)

-- Nvim-Tree
map("n", "<C-n>", ':lua require("nvim-tree").toggle()<CR>', opts)

-- DAP
map("n", "<leader>bp", ':lua require("dap").toggle_breakpoint()<CR>', opts)
map("n", "<leader>dap", ':lua require("dap").continue()<CR>', opts)
map("n", "<leader>dui", ':lua require("dapui").toggle()<CR>', opts)

-- Go
local go_keybindings = function()
  map("n", "<leader>gg", "<Plug>(go-doc)", opts)
  map("n", "<leader>gv", "<Plug>(go-doc-vertical)", opts)
  map("n", "<leader>gdb", "<Plug>(go-doc-browser)", opts)
  map("n", "<leader>gta", "<Plug>(go-alternate-split)", opts)
  map("n", "<leader>gtt", "<Plug>(go-test)", opts)
  map("n", "<leader>gtf", ":GoTestFunc!<cr>", opts)
  map("n", "<leader>gtc", "<Plug>(go-coverage-toggle)", opts)
  map("n", "<leader>gcb", "<Plug>(go-cover-browser)", opts)
  map("n", "<leader>dc", ":DlvConnect vim.env.DLV_SERVER_HOST<CR>", opts)
  map("n", "<leader>ca", ":DlvClearAll <CR>", opts)
  map("n", "<leader>dt", ":DlvToggleBreakpoint <CR>", opts)
end

-- LSP
-- https://github.com/neovim/nvim-lspconfig/blob/da7461b596d70fa47b50bf3a7acfaef94c47727d/doc/lspconfig.txt#L444
-- https://neovim.discourse.group/t/jump-to-definition-in-vertical-horizontal-split/2605/14
map("n", "<leader>gd", ':lua require"telescope.builtin".lsp_definitions({jump_type="vsplit"})<CR>', opts)

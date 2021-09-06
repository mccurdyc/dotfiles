local map = vim.api.nvim_set_keymap
local opts =  {noremap = true}

-- {{ General
vim.g.maplocalleader = ","
vim.g.mapleader = ","

-- Split horizontally.
map('n', '<C-s>', ':sp<CR>', opts)
map('i', 'kj', '<Esc>', opts)

-- replace visual selection globally, confirm.
map('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', opts)

-- Paste more than once.
map('x', 'p', 'pgvy', opts)

-- Clear search highlights.
map('n', '<Leader>cs', ':nohls<CR>', opts)

-- Tab movement.
map('n', '<c-Left>', '<cmd>tabpre<cr>', opts)
map('n', '<c-Right>', '<cmd>tabnext<cr>', opts)

-- }}

-- FZF
-- TODO these need updated for FzfLua
map('n', '<leader>ls', ':FzfSnippets<CR>', opts)
map('n', '<leader>m', ':FzfMarks<CR>', opts)
map('n', '<leader>w', ':FzfWindows<CR>', opts)
map('n', '<leader>c', ':FzfCommits<CR>', opts)
map('n', '<leader>bc', ':FzfBCommits<CR>', opts)
map('n', '<leader>f', ':FzfRg<CR>', opts)
map('n', '<C-p>', ':FzfLua files<CR>', opts)
map('n', '<leader>gs', ':FzfGFiles?<CR>', opts)

-- ALE
map('n', '<silent> <C-k>', '<Plug>(ale_previous)', opts)
map('n', '<silent> <C-j>', '<Plug>(ale_next)', opts)
map('n', '<leader>rn', ':ALERename<CR>', opts)
map('n', '<leader>ss', ':ALESymbolSearch', opts)

-- Go
local go_keybindings = function()
  map('n', '<leader>gg', '<Plug>(go-doc)', opts)
  map('n', '<leader>gv', '<Plug>(go-doc-vertical)', opts)
  map('n', '<leader>gdb', '<Plug>(go-doc-browser)', opts)
  map('n', '<leader>gta', '<Plug>(go-alternate-split)', opts)
  map('n', '<leader>gtt', '<Plug>(go-test)', opts)
  map('n', '<leader>gtf', ':GoTestFunc!<cr>', opts)
  map('n', '<leader>gtc', '<Plug>(go-coverage-toggle)', opts)
  map('n', '<leader>gcb', '<Plug>(go-cover-browser)', opts)
  map('n', '<leader>dc', ':DlvConnect vim.env.DLV_SERVER_HOST<CR>', opts)
  map('n', '<leader>ca', ':DlvClearAll <CR>', opts)
  map('n', '<leader>dt', ':DlvToggleBreakpoint <CR>', opts)
end

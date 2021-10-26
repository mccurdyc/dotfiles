local g = vim.g
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local utils = require("config.utils")
local opt = utils.opt
local autocmd = utils.autocmd
local map = utils.map

-- Language Settings
require("config.go")

-- Other
require("config.git")
require("config.magit")

autocmd(
  "misc_aucmds",
  {
    [[TextYankPost * silent! lua vim.highlight.on_yank()]],
    [[FileType qf set nobuflisted ]],
    [[BufLeave * silent! :wa]]
  },
  true
)

g.loaded_python_provider = 0
g.python_host_prog = "/usr/bin/python2"
g.python3_host_prog = "/usr/bin/python"
g.netrw_browsex_viewer = "xdg-open"

local buffer = {o, bo}
local window = {o, wo}

-- These are the default values
-- opt('cursorcolumn', false, window)
-- opt('cursorline' false, window)
-- opt('smarttab', true)
-- opt('autoread', true)
-- opt('errorbells' false)
-- opt('visualbell' false)
-- opt('belloff', 'all')
-- opt('smarttab', true)

-- TODO consider deleting
-- opt('timeoutlen', 500)
-- opt('ttimeoutlen', 500)
-- opt(undodir=~/.config/nvim/.undodir
-- undofile
-- filetype plugin indent on

opt("clipboard", "unnamedplus")
opt("swapfile", false, buffer)
opt("title", true)
opt("wrap", false, window)
opt("number", true, window) -- TODO confirm
opt("linebreak", true, window)
opt("showbreak", "━━")
opt("breakindent", true, window)
opt("tabstop", 2, buffer)
opt("shiftwidth", 2)
opt("expandtab", true, buffer)
opt("shiftround", true)
opt("lazyredraw", true)
opt("colorcolumn", "80", window)
opt("hidden", true)
opt("list", true)
opt("syntax", "enable")
opt("hlsearch", false)
opt("splitbelow", true)
opt("splitright", true)
opt("showmode", false)

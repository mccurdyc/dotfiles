require("bqf").setup(
  {
    auto_enable = true,
    magic_window = false,
    auto_resize_height = true,
    preview = {
      auto_preview = false
    },
    func_map = {
      vsplit = "",
      ptogglemode = "z,",
      stoggleup = ""
    },
    filter = {
      fzf = {
        action_for = {["ctrl-s"] = "split"},
        extra_opts = {"--bind", "ctrl-o:toggle-all", "--prompt", "> "}
      }
    }
  }
)

vim.cmd("augroup quickfix")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType qf setlocal nonumber colorcolumn=")
vim.cmd("autocmd FileType qf setlocal wrap")
vim.cmd("augroup END")

vim.cmd("augroup listclose")
vim.cmd("autocmd!")
vim.cmd('autocmd WinEnter * if winnr(\'$\') == 1 && &buftype == "quickfix"|q|endif')
vim.cmd(
  'autocmd WinEnter * if winnr(\'$\') == 1 && (&buftype == "quickfix" || &buftype == "locationlist") | lclose | endif'
)
vim.cmd("augroup END")

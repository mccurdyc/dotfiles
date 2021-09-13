require("bqf").setup(
  {
    auto_enable = true,
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border_chars = {"┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█"}
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

-- TODO - convert to Lua
-- aug QuickFix
--   au FileType qf setlocal nonumber colorcolumn=
--   -- wrap long lines in quickfix - https://github.com/fatih/vim-go/issues/1271
--   autocmd FileType qf setlocal wrap
-- aug END
--
-- aug ListClose
--   au!
--   au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
--   au WinEnter * if winnr('$') == 1 && (&buftype == "quickfix" || &buftype == "locationlist") | lclose | endif
-- aug END
--
-- au FileType qf call AdjustWindowHeight(3, 10)
-- function! AdjustWindowHeight(minheight, maxheight)
--     let l = 1
--     let n_lines = 0
--     let w_width = winwidth(0)
--     while l <= line('$')
--         " number to float for division
--         let l_len = strlen(getline(l)) + 0.0
--         let line_width = l_len/w_width
--         let n_lines += float2nr(ceil(line_width))
--         let l += 1
--     endw
--     exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
-- endfunction
-- -- https://gist.github.com/juanpabloaj/5845848

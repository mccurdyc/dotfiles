require("formatter").setup(
  {
    filetype = {
      sh = {
        function()
          return {
            exe = "shfmt",
            args = {"-i", 2},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

-- https://github.com/mhartington/formatter.nvim#format-on-save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua FormatWrite
augroup END
]],
  true
)

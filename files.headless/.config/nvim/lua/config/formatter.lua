require('formatter').setup({
  filetype = {
    terraform = {
      function()
        return {
          exe = "terraform",
          args = {"fmt", '-write=true', '-'},
          cwd = vim.fn.expand('%:p:h'),
          stdin = true
        }
      end
    },
    hcl= {
      function()
        return {
          exe = "terraform",
          args = {"fmt", '-write=true', '-'},
          cwd = vim.fn.expand('%:p:h'),
          stdin = true
        }
      end
    },
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
    sh = {
       function()
         return {
           exe = "shfmt",
           args = { "-i", 2 },
           stdin = true,
         }
       end,
   },
  },
})

-- https://github.com/mhartington/formatter.nvim#format-on-save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.tf,*.hcl,*.rs,*.sh FormatWrite
augroup END
]], true)

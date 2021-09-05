-- Run PackerCompile when plugins.lua is written.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({function()
  -- https://github.com/wbthomason/packer.nvim/blob/daec6c759f95cd8528e5dd7c214b18b4cec2658c/doc/packer.txt#L534

  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/diagnostic-nvim'
  use 'tpope/vim-fugitive'
  use 'jreybert/vimagit'
  use 'tpope/vim-surround'
  use 'airblade/vim-gitgutter'
  use { 'fatih/vim-go',
      ft = 'go',
      run = ':GoUpdateBinaries',
  }
  use { 'sebdah/vim-delve',
      ft ='go',
  }
  use { 'rust-lang/rust.vim',
      ft = 'rs',
  }
  use 'hashivim/vim-terraform'
  use 'edkolev/tmuxline.vim'
  use 'vim-scripts/colorizer'
  use 'itchyny/lightline.vim'
  use 'mccurdyc/vim-base16-lightline'
  use 'mccurdyc/base16-vim'
  use 'SirVer/ultisnips'
  use 'mccurdyc/vim-snippets'
  use { 'junegunn/fzf', run = './install --bin', }

  use {
    'w0rp/ale',
    ft = { 'sh', 'zsh', 'bash', 'html', 'markdown', 'racket', 'vim', 'go', 'rs', 'tf' },
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }
  use 'airblade/vim-rooter'
  use 'tomtom/tcomment_vim'
  use 'ruanyl/vim-gh-line'
end,
-- Use a floating window
-- https://github.com/wbthomason/packer.nvim#using-a-floating-window
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})


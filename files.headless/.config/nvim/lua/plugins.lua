-- Bootstrapping to ensure packer is installed
local fn = vim.fn
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'yay', '-S', 'nvim-packer-git'})
  vim.cmd 'packadd packer.nvim'
end

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

  -- NeoVim LSP
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/diagnostic-nvim'

  -- Linting
  use {
    'w0rp/ale',
    ft = { 'sh', 'zsh', 'bash', 'html', 'markdown', 'racket', 'vim', 'go', 'rs', 'tf' },
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'jreybert/vimagit'
  use 'ruanyl/vim-gh-line'

  -- Go
  use { 'fatih/vim-go',
      ft = 'go',
      run = ':GoUpdateBinaries',
  }
  use { 'sebdah/vim-delve',
      ft ='go',
  }

  -- Rust
  use { 'rust-lang/rust.vim',
      ft = 'rs',
  }

  -- Terraform
  use { 'hashivim/vim-terraform',
    ft = { 'tf', 'hcl' }
  }

  -- General
  use 'tpope/vim-surround'
  use 'airblade/vim-gitgutter'
  use 'SirVer/ultisnips'
  use 'mccurdyc/vim-snippets'
  use 'airblade/vim-rooter'
  use 'tomtom/tcomment_vim'
  use { 'junegunn/fzf', run = './install --bin', }

  -- Themes / Colors
  use 'edkolev/tmuxline.vim'
  use 'vim-scripts/colorizer'
  use 'itchyny/lightline.vim'
  use 'mccurdyc/vim-base16-lightline'
  use 'mccurdyc/base16-vim'
end,
-- Use a floating window
-- https://github.com/wbthomason/packer.nvim#using-a-floating-window
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})


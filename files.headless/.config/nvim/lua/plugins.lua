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

  -- General
  use {
    'tpope/vim-surround',
    'SirVer/ultisnips',
    'mccurdyc/vim-snippets',
    'airblade/vim-rooter',
    'tomtom/tcomment_vim',
    'nvim-lua/plenary.nvim',
    'vijaymarupudi/nvim-fzf',
  }
  use { 'ibhagwan/fzf-lua',
      requires = {
        'vijaymarupudi/nvim-fzf',
        'kyazdani42/nvim-web-devicons'
      },
      config = [[require('config.fzf')]],
  }

  -- NeoVim LSP
  use {
    -- 'nvim-lua/completion-nvim',
    'nvim-lua/diagnostic-nvim',
    'folke/trouble.nvim',
    'onsails/lspkind-nvim',
  }
  use { 'neovim/nvim-lspconfig',
    config = [[require('config.lsp')]],
  }

  -- Completion
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    config = [[require('config.completion')]],
    event = 'InsertEnter *',
  }

  -- Linting
  -- use { 'w0rp/ale',
  --   ft = { 'sh', 'zsh', 'bash', 'html', 'markdown', 'racket', 'vim', 'go', 'rs', 'tf' },
  --   cmd = 'ALEEnable',
  --   config = [[require('config.ale')]],
  -- }

  -- Git
  use {
    'tpope/vim-fugitive',
    'jreybert/vimagit',
    'ruanyl/vim-gh-line',
  }
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = [[require('config.gitsigns')]],
  }
  use { 'sindrets/diffview.nvim',
    config = [[require('config.diffview')]],
  }
  use { 'TimUntersberger/neogit',
    cmd = 'Neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    },
    config = [[require('config.neogit')]],
  }

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

  -- Styling
  use {
    'mccurdyc/base16-vim',
    'kyazdani42/nvim-web-devicons',
  }
  use { 'nvim-treesitter/nvim-treesitter',
    config = [[require('config.treesitter')]],
    run = ':TSUpdate',
  }
  use { 'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = [[require('config.statusline')]],
    options = {theme = 'gruvbox'},
  }

  -- Profiling
  -- usage: nvim --startuptime and then :StartupTime
  use { 'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = [[vim.g.startuptime_tries = 10]],
  }
end,

-- Use a floating window
-- https://github.com/wbthomason/packer.nvim#using-a-floating-window
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

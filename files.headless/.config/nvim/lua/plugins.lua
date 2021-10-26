-- Bootstrapping to ensure packer is installed
local fn = vim.fn
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"yay", "-S", "nvim-packer-git"})
  vim.cmd "packadd packer.nvim"
end

-- Run PackerCompile when plugins.lua is written.
vim.cmd(
  [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
)

return require("packer").startup(
  {
    function()
      -- https://github.com/wbthomason/packer.nvim/blob/daec6c759f95cd8528e5dd7c214b18b4cec2658c/doc/packer.txt#L534
      use "wbthomason/packer.nvim"

      -- General
      use {
        "tpope/vim-surround",
        "mccurdyc/vim-snippets",
        "tomtom/tcomment_vim",
        "nvim-lua/plenary.nvim"
      }
      use {
        "kevinhwang91/nvim-bqf",
        config = [[require('config.quickfix')]]
      }
      use {
        "mhartington/formatter.nvim",
        config = [[require('config.formatter')]]
      }
      use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
      }
      use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/plenary.nvim"}},
        config = [[require('config.telescope')]]
      }
      -- use {
      --   "ahmedkhalf/project.nvim",
      --   config = [[require('config.project-nvim')]]
      -- }
      use {
        "kyazdani42/nvim-tree.lua",
        config = [[require('config.nvim-tree')]]
      }

      -- NeoVim LSP
      use {
        "neovim/nvim-lspconfig",
        config = [[require('config.lsp')]]
      }

      -- Completion
      -- use {
      --   "ms-jpq/coq_nvim",
      --   branch = "coq",
      --   run = ":COQdeps"
      -- }
      -- use {"ms-jpq/coq.artifacts", branch = "artifacts"} -- 9000+ Snippets
      use {
        "hrsh7th/nvim-cmp",
        config = [[require('config.completion')]]
      }
      use {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path"
      }
      -- Completion (Snippets)
      use {
        "SirVer/ultisnips",
        "quangnguyen30192/cmp-nvim-ultisnips"
      }

      -- Linting
      use {
        "dense-analysis/ale",
        config = [[require('config.ale')]]
      }

      -- Git
      use {
        "tpope/vim-fugitive",
        "jreybert/vimagit",
        "ruanyl/vim-gh-line"
      }
      use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = [[require('config.gitsigns')]]
      }
      -- use {
      --   "sindrets/diffview.nvim",
      --   config = [[require('config.diffview')]]
      -- }
      -- use {
      --   "TimUntersberger/neogit",
      --   cmd = "Neogit",
      --   requires = {
      --     "nvim-lua/plenary.nvim",
      --     "sindrets/diffview.nvim"
      --   },
      --   config = [[require('config.neogit')]]
      -- }

      -- Go
      use {
        "fatih/vim-go",
        ft = "go",
        run = ":GoUpdateBinaries"
      }

      -- Rust
      use {
        "rust-lang/rust.vim"
      }

      -- Terraform
      use {
        "hashivim/vim-terraform",
        config = [[require('config.terraform')]]
      }

      -- Styling
      use {
        "mccurdyc/base16-vim",
        "kyazdani42/nvim-web-devicons"
      }
      use {
        "nvim-treesitter/nvim-treesitter",
        config = [[require('config.treesitter')]],
        run = ":TSUpdate"
      }
      use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = [[require('config.statusline')]]
      }
      use {
        "p00f/nvim-ts-rainbow",
        config = [[require('config.rainbow')]]
      }

      -- Debugging
      use {
        "rcarriga/nvim-dap-ui"
      }
      use {
        "mfussenegger/nvim-dap",
        config = [[require('config.dap')]]
      }

      -- Profiling
      -- usage: nvim --startuptime and then :StartupTime
      use {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = [[vim.g.startuptime_tries = 10]]
      }
    end
  }
)

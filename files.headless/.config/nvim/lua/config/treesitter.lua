require('nvim-treesitter.configs').setup {
  ensure_installed = { "comment", "lua", "rust", "yaml", "go", "hcl" },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
}


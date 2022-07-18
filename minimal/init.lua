local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo

local function opt(o, v, scopes)
  scopes = scopes or {o_s}
  for _, s in ipairs(scopes) do
    s[o] = v
  end
end

local buffer = {o, bo}
local window = {o, wo}

cmd("filetype plugin indent on")

opt("clipboard", "unnamedplus")
opt("swapfile", false, buffer)
opt("title", true)
opt("wrap", false, window)
opt("number", true, window)
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
opt("foldminlines", 5)
opt("foldmethod", "indent")

require("packer").startup(
  {
    function()
      -- https://github.com/wbthomason/packer.nvim/blob/daec6c759f95cd8528e5dd7c214b18b4cec2658c/doc/packer.txt#L534
      use "wbthomason/packer.nvim"

      use {
        "kevinhwang91/nvim-bqf"
      }
    end
  }
)

require("bqf").setup(
  {
    auto_enable = true,
    auto_resize_height = true
  }
)

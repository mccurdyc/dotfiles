-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/mccurdyc/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/mccurdyc/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/mccurdyc/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/mccurdyc/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/mccurdyc/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ale = {
    commands = { "ALEEnable" },
    config = { "vim.cmd[[ALEEnable]]" },
    loaded = false,
    needs_bufread = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/ale"
  },
  ["base16-vim"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/base16-vim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/cmp_luasnip"
  },
  ["diagnostic-nvim"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/diagnostic-nvim"
  },
  ["diffview.nvim"] = {
    config = { "require('config.diffview')" },
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["fzf-lua"] = {
    config = { "require('config.fzf')" },
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/fzf-lua"
  },
  ["gitsigns.nvim"] = {
    config = { "require('config.gitsigns')" },
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "require('config.statusline')" },
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "require('config.neogit')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["nvim-cmp"] = {
    after = { "cmp-nvim-lsp", "cmp-nvim-lua", "cmp-buffer", "cmp_luasnip", "cmp-path" },
    config = { "require('config.completion')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-fzf"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/nvim-fzf"
  },
  ["nvim-lspconfig"] = {
    config = { "require('config.lsp')" },
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/rust.vim"
  },
  tcomment_vim = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/tcomment_vim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-delve"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-delve"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gh-line"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/vim-gh-line"
  },
  ["vim-go"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    config = { "vim.g.startuptime_tries = 10" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-terraform"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-terraform"
  },
  vimagit = {
    loaded = true,
    path = "/home/mccurdyc/.local/share/nvim/site/pack/packer/start/vimagit"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require('config.lsp')
time([[Config for nvim-lspconfig]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
require('config.fzf')
time([[Config for fzf-lua]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require('config.statusline')
time([[Config for lualine.nvim]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
require('config.diffview')
time([[Config for diffview.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require('config.gitsigns')
time([[Config for gitsigns.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ALEEnable lua require("packer.load")({'ale'}, { cmd = "ALEEnable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType html ++once lua require("packer.load")({'ale'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType zsh ++once lua require("packer.load")({'ale'}, { ft = "zsh" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'ale', 'vim-go', 'vim-delve'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType tf ++once lua require("packer.load")({'ale', 'vim-terraform'}, { ft = "tf" }, _G.packer_plugins)]]
vim.cmd [[au FileType rs ++once lua require("packer.load")({'ale', 'rust.vim'}, { ft = "rs" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'ale'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'ale'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType hcl ++once lua require("packer.load")({'vim-terraform'}, { ft = "hcl" }, _G.packer_plugins)]]
vim.cmd [[au FileType bash ++once lua require("packer.load")({'ale'}, { ft = "bash" }, _G.packer_plugins)]]
vim.cmd [[au FileType sh ++once lua require("packer.load")({'ale'}, { ft = "sh" }, _G.packer_plugins)]]
vim.cmd [[au FileType racket ++once lua require("packer.load")({'ale'}, { ft = "racket" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
time([[Sourcing ftdetect script at: /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]], true)
vim.cmd [[source /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]]
time([[Sourcing ftdetect script at: /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]], false)
time([[Sourcing ftdetect script at: /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], true)
vim.cmd [[source /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]]
time([[Sourcing ftdetect script at: /home/mccurdyc/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
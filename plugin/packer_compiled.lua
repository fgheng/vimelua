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
local package_path_str = "/home/forever/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/forever/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/forever/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/forever/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/forever/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
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
  ["AutoSave.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.utils.AutoSave\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/AutoSave.nvim",
    url = "https://github.com/Pocco81/AutoSave.nvim"
  },
  ["Comment.nvim"] = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.comment.Comment\frequire\0" },
    keys = { { "", "<leader>cc" }, { "", "<leader>cb" }, { "", "<leader>cl" }, { "", "<leader>bl" }, { "", "<leader>co" }, { "", "<leader>cO" }, { "", "<leader>ca" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    after = { "friendly-snippets" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["NeoZoom.lua"] = {
    commands = { "NeoZoomToggle" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.windows.NeoZoom\frequire\0" },
    keys = { { "", "<c-w>o" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/NeoZoom.lua",
    url = "https://github.com/nyngwang/NeoZoom.lua"
  },
  ["aerial.nvim"] = {
    commands = { "AerialOpen", "AerialToggle" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.lsp.aerial\frequire\0" },
    keys = { { "", "<F3>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins.lines.bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help/after/plugin/cmp_nvim_lsp_signature_help.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot.vim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31plugins.completion.copilot\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  edge = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/edge",
    url = "https://github.com/sainnhe/edge"
  },
  ["friendly-snippets"] = {
    load_after = {
      LuaSnip = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    commands = { "Gitsigns" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins.git.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.editor.hop\frequire\0" },
    keys = { { "", "f" }, { "", "F" }, { "", "tl" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    commands = { "IndentBlanklineToggle", "IndentBlanklineEnable", "IndentBlanklineRefresh" },
    config = { "\27LJ\2\n?\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0$plugins.editor.indent-blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugins.lines.lualine\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  neogen = {
    commands = { "Neogen" },
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.comment.neogen\frequire\0" },
    keys = { { "n", "<leader>dd" }, { "n", "<leader>df" }, { "n", "<leader>dc" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins.editor.neoscroll\frequire\0" },
    keys = { { "", "<C-u>" }, { "", "<C-d>" }, { "", "<C-b>" }, { "", "<C-f>" }, { "", "<C-y>" }, { "", "<C-e>" }, { "", "zt" }, { "", "zz" }, { "", "zb" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  nvim = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"plugins.editor.nvim-autopairs\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp_luasnip", "cmp-buffer", "cmp-path", "cmp-cmdline", "cmp-nvim-lsp-signature-help", "nvim-autopairs" },
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 plugins.completion.nvim-cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    commands = { "ColorizerToggle" },
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.utils.nvim-colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-comment-frame"] = {
    config = { "\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'plugins.comment.nvim-comment-frame\frequire\0" },
    keys = { { "", "<leader>dm" }, { "", "<leader>dl" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-comment-frame",
    url = "https://github.com/s1n7ax/nvim-comment-frame"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-virtual-text", "nvim-dap-ui" },
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.debug.dap.dap-config\frequire\0" },
    keys = { { "", "<F5>" }, { "", "<F6>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins.debug.dap.dap-ui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\nG\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0,plugins.debug.dap.nvim-dap-virtual-text\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-gps"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.lines.nvim-gps\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-gps",
    url = "https://github.com/SmiteshP/nvim-gps"
  },
  ["nvim-hlslens"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 plugins.editor.nvim-hlslens\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31plugins.lsp.nvim-lightbulb\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lsp-installer"] = {
    after = { "telescope.nvim" },
    commands = { "LspInstall", "LspInstallInfo", "LspUninstall", "LspUninstallAll", "LspInstallLog", "LspPrintInstalled" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31plugins.lsp.nvim-lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins.utils.nvim-notify\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-scrollbar"] = {
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"plugins.editor.nvim-scrollbar\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeOpen", "NvimTreeToggle" },
    config = { "\27LJ\2\n?\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0$plugins.file_explorer.nvim-tree\frequire\0" },
    keys = { { "", "<F2>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-rainbow" },
    config = { "\27LJ\2\n>\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0#plugins.editor.nvim-treesitter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n?\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0$plugins.theme.nvim-web-devicons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-window.git"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 plugins.windows.nvim-window\frequire\0" },
    keys = { { "", "-" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/nvim-window.git",
    url = "https://gitlab.com/yorickpeterse/nvim-window"
  },
  ["one-nvim"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/one-nvim",
    url = "https://github.com/Th3Whit3Wolf/one-nvim"
  },
  ["onenord.nvim"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/onenord.nvim",
    url = "https://github.com/rmehri01/onenord.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["smart-splits.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.windows.smart-splits\frequire\0" },
    keys = { { "", "<c-w>r" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/smart-splits.nvim",
    url = "https://github.com/fgheng/smart-splits.nvim"
  },
  sniprun = {
    commands = { "SnipRun" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.project.sniprun\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/sniprun",
    url = "https://github.com/michaelb/sniprun"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.editor.surround\frequire\0" },
    keys = { { "n", "cs" }, { "n", "ds" }, { "n", "ys" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/surround.nvim",
    url = "https://github.com/ur4ltz/surround.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n>\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0#plugins.fuzzy_finder.telescope\frequire\0" },
    keys = { { "", "<space><space>" }, { "", "<space>f" }, { "", "<space>s" }, { "", "<space>b" }, { "", "?" }, { "", "<space>a" }, { "", "<space>r" }, { "", "<space>j" } },
    load_after = {
      ["nvim-lsp-installer"] = true
    },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tmux.nvim"] = {
    cond = { "\27LJ\2\n>\0\0\3\0\3\0\n6\0\0\0009\0\1\0'\2\2\0B\0\2\2\v\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\tTMUX\vgetenv\aos\0" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins.windows.tmux\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/tmux.nvim",
    url = "https://github.com/aserowy/tmux.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 plugins.utils.todo-comments\frequire\0" },
    keys = { { "", "<space>t" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["vim-floaterm"] = {
    commands = { "FloatermNew" },
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"plugins.terminal.vim-floaterm\frequire\0" },
    keys = { { "", "<m-=>" }, { "", "<m-+>" }, { "", "<leader>e" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-matchup"] = {
    after_files = { "/home/forever/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31plugins.editor.vim-matchup\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-repeat"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vscode.nvim"] = {
    loaded = true,
    path = "/home/forever/.local/share/nvim/site/pack/packer/start/vscode.nvim",
    url = "https://github.com/Mofiqul/vscode.nvim"
  },
  ["winbar.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins.lines.winbar\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/winbar.nvim",
    url = "https://github.com/fgheng/winbar.nvim"
  },
  ["winshift.nvim"] = {
    commands = { "WinShift" },
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins.windows.winshift\frequire\0" },
    keys = { { "", "=" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/forever/.local/share/nvim/site/pack/packer/opt/winshift.nvim",
    url = "https://github.com/sindrets/winshift.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^LuaSnip"] = "LuaSnip",
  ["^cmp"] = "nvim-cmp",
  ["^dap"] = "nvim-dap",
  ["^lualine"] = "lualine.nvim",
  ["^luasnip"] = "LuaSnip",
  ["^nvim%-cmp"] = "nvim-cmp",
  ["^nvim%-lsp%-installer"] = "nvim-lsp-installer",
  ["^nvim_lsp_installer"] = "nvim-lsp-installer",
  ["^plenary"] = "plenary.nvim",
  aerial = "aerial.nvim",
  cmp_nvim_lsp = "cmp-nvim-lsp",
  gps = "nvim-gps",
  hlslens = "nvim-hlslens",
  ["lspconfig.*"] = "nvim-lspconfig",
  ["nvim-gps"] = "nvim-gps",
  ["telescope.*"] = "telescope.nvim",
  treesitter = "nvim-treesitter"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end


-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gitsigns lua require("packer.load")({'gitsigns.nvim'}, { cmd = "Gitsigns", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file WinShift lua require("packer.load")({'winshift.nvim'}, { cmd = "WinShift", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SnipRun lua require("packer.load")({'sniprun'}, { cmd = "SnipRun", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NeoZoomToggle lua require("packer.load")({'NeoZoom.lua'}, { cmd = "NeoZoomToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file IndentBlanklineToggle lua require("packer.load")({'indent-blankline.nvim'}, { cmd = "IndentBlanklineToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file IndentBlanklineEnable lua require("packer.load")({'indent-blankline.nvim'}, { cmd = "IndentBlanklineEnable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file IndentBlanklineRefresh lua require("packer.load")({'indent-blankline.nvim'}, { cmd = "IndentBlanklineRefresh", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerToggle lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FloatermNew lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermNew", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogen lua require("packer.load")({'neogen'}, { cmd = "Neogen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspInstall lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspInstallInfo lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspInstallInfo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspUninstall lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspUninstallAll lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspUninstallAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspInstallLog lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspInstallLog", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspPrintInstalled lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspPrintInstalled", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file AerialToggle lua require("packer.load")({'aerial.nvim'}, { cmd = "AerialToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file AerialOpen lua require("packer.load")({'aerial.nvim'}, { cmd = "AerialOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeOpen lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> - <cmd>lua require("packer.load")({'nvim-window.git'}, { keys = "-", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>dc <cmd>lua require("packer.load")({'neogen'}, { keys = "<lt>leader>dc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> ? <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "?", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-d> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-d>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ys <cmd>lua require("packer.load")({'surround.nvim'}, { keys = "ys", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>e <cmd>lua require("packer.load")({'vim-floaterm'}, { keys = "<lt>leader>e", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <c-w>r <cmd>lua require("packer.load")({'smart-splits.nvim'}, { keys = "<lt>c-w>r", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> tl <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "tl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-e> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-e>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>dl <cmd>lua require("packer.load")({'nvim-comment-frame'}, { keys = "<lt>leader>dl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>dm <cmd>lua require("packer.load")({'nvim-comment-frame'}, { keys = "<lt>leader>dm", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ds <cmd>lua require("packer.load")({'surround.nvim'}, { keys = "ds", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ca <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>ca", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>df <cmd>lua require("packer.load")({'neogen'}, { keys = "<lt>leader>df", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <F6> <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>F6>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> = <cmd>lua require("packer.load")({'winshift.nvim'}, { keys = "=", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> zb <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "zb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> zz <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "zz", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>cl <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>cl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-y> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-y>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-f> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-f>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space><space> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>space><lt>space>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-u> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-u>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>t <cmd>lua require("packer.load")({'todo-comments.nvim'}, { keys = "<lt>space>t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-b> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-b>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <F3> <cmd>lua require("packer.load")({'aerial.nvim'}, { keys = "<lt>F3>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <F2> <cmd>lua require("packer.load")({'nvim-tree.lua'}, { keys = "<lt>F2>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> F <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <c-w>o <cmd>lua require("packer.load")({'NeoZoom.lua'}, { keys = "<lt>c-w>o", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>cc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>cc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>j <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>space>j", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <m-+> <cmd>lua require("packer.load")({'vim-floaterm'}, { keys = "<lt>m-+>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>cb <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>cb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>f <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>space>f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>s <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>space>s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>a <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>space>a", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>cO <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>cO", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>dd <cmd>lua require("packer.load")({'neogen'}, { keys = "<lt>leader>dd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <F5> <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>F5>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> f <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> zt <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "zt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>bl <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>bl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>co <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>co", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>r <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>space>r", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>b <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>space>b", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> cs <cmd>lua require("packer.load")({'surround.nvim'}, { keys = "cs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <m-=> <cmd>lua require("packer.load")({'vim-floaterm'}, { keys = "<lt>m-=>", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType xml ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "xml" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "html" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au CmdlineChanged * ++once lua require("packer.load")({'nvim-scrollbar'}, { event = "CmdlineChanged *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'gitsigns.nvim', 'bufferline.nvim', 'lualine.nvim', 'nvim-web-devicons', 'vim-repeat', 'todo-comments.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au CursorMoved * ++once lua require("packer.load")({'nvim-lightbulb', 'nvim-treesitter', 'nvim-lspconfig', 'winbar.nvim', 'tmux.nvim', 'nvim-scrollbar', 'nvim-gps', 'vim-matchup'}, { event = "CursorMoved *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'nvim-notify'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CmdlineEnter * ++once lua require("packer.load")({'nvim-scrollbar'}, { event = "CmdlineEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-lightbulb', 'copilot.vim', 'nvim-treesitter', 'nvim-lspconfig', 'AutoSave.nvim', 'winbar.nvim', 'nvim-gps', 'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au WinScrolled * ++once lua require("packer.load")({'nvim-treesitter', 'nvim-scrollbar'}, { event = "WinScrolled *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

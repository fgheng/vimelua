local packer_boot_strap = false
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_boot_strap = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }) and vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/lewis6991/impatient.nvim.git",
        vim.fn.stdpath("data") .. "/site/pack/packer/start/impatient.nvim",
    })
    if packer_boot_strap then
        vim.api.nvim_command([[packadd packer.nvim]])
    else
        return
    end
end

require("impatient") -- run :LuaCacheClear

vim.defer_fn(function()
    return require("packer").startup({
        function(use)
            use({ "lewis6991/impatient.nvim" }) -- to reduce loade time, run :LuaCacheClear
            use({ "wbthomason/packer.nvim" })

            ----------------------------------------------------------------------
            --                               lsp                                --
            ----------------------------------------------------------------------
            -- use({
            --     {
            --         "williamboman/mason.nvim",
            --         module = { "mason" },
            --         config = function()
            --             require("plugins.lsp.mason")
            --         end,
            --     },
            --     {
            --         "williamboman/mason-lspconfig.nvim",
            --         module = { "mason-lspconfig" },
            --     },
            --     {
            --         "neovim/nvim-lspconfig",
            --         module = { "lspconfig" },
            --         config = function()
            --             require("plugins.lsp.nvim-lspconfig")
            --         end,
            --         -- after = 'mason.nvim',
            --         event = { "InsertEnter", "CursorMoved" },
            --     },
            --     {
            --         "jose-elias-alvarez/null-ls.nvim",
            --         module = { "null-ls" },
            --         config = function()
            --             require("plugins.lsp.null-ls")
            --         end,
            --         after = "nvim-lspconfig",
            --         requires = { "nvim-lua/plenary.nvim" },
            --     },
            --     {
            --         "jayp0521/mason-null-ls.nvim",
            --         module = { "mason-null-ls" },
            --         config = function()
            --             require("plugins.lsp.mason-null-ls")
            --         end,
            --         event = { "BufRead" },
            --         -- after = {"null-ls"}
            --     },
            --     {
            --         "kosayoda/nvim-lightbulb",
            --         config = function()
            --             require("plugins.lsp.nvim-lightbulb")
            --         end,
            --         event = { "InsertEnter", "CursorMoved" },
            --     },
            --     {
            --         "weilbith/nvim-code-action-menu",
            --         config = function()
            --             require("plugins.lsp.nvim-code-action-menu")
            --         end,
            --         cmd = "CodeActionMenu",
            --         keys = {
            --             { "n", "ca" },
            --         },
            --     },
            --     {
            --         "filipdutescu/renamer.nvim",
            --         branch = "master",
            --         requires = { { "nvim-lua/plenary.nvim" } },
            --         config = function()
            --             require("plugins.lsp.renamer")
            --         end,
            --         keys = {
            --             { "n", "<leader>rn" },
            --         },
            --     },
            --     {
            --         "mfussenegger/nvim-jdtls",
            --         ft = { "java" },
            --         config = function()
            --             require("plugins.lsp.nvim-jdtls")
            --         end,
            --     },
            --     {
            --         -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            --         "fgheng/lsp_lines.nvim",
            --         -- disable = true,
            --         config = function()
            --             require("plugins.lsp.lsp_lines")
            --         end,
            --         event = { "InsertEnter", "CursorMoved" },
            --     },
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                            completion                            --
            -- ----------------------------------------------------------------------
            -- use({
            --     {
            --         "hrsh7th/nvim-cmp",
            --         module = { "cmp" },
            --         config = function()
            --             require("plugins.completion.nvim-cmp")
            --         end,
            --         event = "InsertEnter *",
            --     },
            --     -- snippets
            --     { "L3MON4D3/LuaSnip", module = { "luasnip" } },
            --     { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            --     { "rafamadriz/friendly-snippets", after = "LuaSnip" },
            --     -- sources
            --     { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
            --     { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            --     { "hrsh7th/cmp-path", after = "nvim-cmp" },
            --     -- { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
            --     { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
            --     { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
            --
            --     {
            --         "github/copilot.vim",
            --         disable = true,
            --         event = "InsertEnter",
            --         config = function()
            --             require("plugins.completion.copilot")
            --         end,
            --     },
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                             comment                              --
            -- ----------------------------------------------------------------------
            -- use({
            --     {
            --         "danymat/neogen", -- document generate
            --         config = function()
            --             require("plugins.comment.neogen")
            --         end,
            --         requires = {
            --             { "nvim-treesitter/nvim-treesitter" },
            --         },
            --         cmd = { "Neogen" },
            --         keys = {
            --             { "n", "<leader>dd" },
            --             { "n", "<leader>df" },
            --             { "n", "<leader>dc" },
            --         },
            --     },
            --     {
            --         "numToStr/Comment.nvim", -- comment
            --         config = function()
            --             require("plugins.comment.Comment")
            --         end,
            --         keys = {
            --             { "v", "<leader>cc" },
            --             { "v", "<leader>cb" },
            --             { "n", "<leader>cl" },
            --             { "n", "<leader>bl" },
            --             { "n", "<leader>co" },
            --             { "n", "<leader>cO" },
            --             { "n", "<leader>ca" },
            --         },
            --     },
            --     {
            --         "s1n7ax/nvim-comment-frame",
            --         config = function()
            --             require("plugins.comment.nvim-comment-frame")
            --         end,
            --         keys = {
            --             "<leader>dm",
            --             "<leader>dl",
            --         },
            --     },
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                           fuzzy_finder                           --
            -- ----------------------------------------------------------------------
            -- use({
            --     "nvim-telescope/telescope.nvim",
            --     module_pattern = "telescope.*",
            --     config = function()
            --         require("plugins.fuzzy_finder.telescope")
            --     end,
            --     requires = {
            --         { "nvim-lua/plenary.nvim" },
            --         { "nvim-telescope/telescope-ui-select.nvim" },
            --         {
            --             "nvim-telescope/telescope-fzf-native.nvim",
            --             run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            --         },
            --         { "nvim-telescope/telescope-live-grep-args.nvim" },
            --         { "nvim-telescope/telescope-file-browser.nvim" },
            --         { "nvim-telescope/telescope-symbols.nvim" },
            --     },
            --     cmd = { "Telescope" },
            --     keys = {
            --         "<CR>",
            --         "<space>f",
            --         "<space>s",
            --         "<space>g",
            --         "<space>b",
            --         "<space>a",
            --         "<space>r",
            --         "<space>j",
            --         "<space>o",
            --         "<space>O",
            --         "<space>e",
            --     },
            --     -- after = { 'mason.nvim' }
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                         file and outline                         --
            -- ----------------------------------------------------------------------
            -- use({
            --     -- file mamager
            --     {
            --         "kyazdani42/nvim-tree.lua",
            --         config = function()
            --             require("plugins.file_explorer.nvim-tree")
            --         end,
            --         requires = {
            --             { "kyazdani42/nvim-web-devicons", opt = true },
            --         },
            --         cmd = { "NvimTreeOpen", "NvimTreeToggle" },
            --         keys = { "<F2>" },
            --     },
            --     -- outline
            --     {
            --         "stevearc/aerial.nvim", -- lspconfig, lualine
            --         disable = true,
            --         module_pattern = "aerial",
            --         config = function()
            --             require("plugins.lsp.aerial")
            --         end,
            --         cmd = { "AerialOpen", "AerialToggle" },
            --         keys = "<F3>",
            --         -- event = { 'InsertEnter', 'CursorMoved' }
            --     },
            --     {
            --         "simrat39/symbols-outline.nvim",
            --         config = function()
            --             require("plugins.lsp.symbols-outline")
            --         end,
            --         cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
            --         keys = { "<F3>" },
            --     },
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                               git                                --
            -- ----------------------------------------------------------------------
            -- use({
            --     "lewis6991/gitsigns.nvim",
            --     config = function()
            --         require("plugins.git.gitsigns")
            --     end,
            --     cmd = { "Gitsigns" },
            --     event = { "BufRead" },
            -- })
            --
            -- use({
            --     "sindrets/diffview.nvim",
            --     requires = {
            --         { "nvim-lua/plenary.nvim" },
            --         { "kyazdani42/nvim-web-devicons", opt = true },
            --     },
            --     config = function()
            --         require("plugins.git.diffview")
            --     end,
            --     cmd = {
            --         "DiffviewOpen",
            --         "DiffviewLog",
            --         "DiffviewFileHistory",
            --     },
            --     keys = {
            --         { "n", "<leader>gd" },
            --         -- { "n", "<leader>gc" },
            --         { "n", "<leader>gh" },
            --     },
            -- })
            -- -- use { 'tanvirtin/vgit.nvim',
            -- --     config = function()
            -- --         require('plugins.git.vgit')
            -- --     end,
            -- --     requires = {
            -- --         { 'nvim-lua/plenary.nvim' },
            -- --         { 'kyazdani42/nvim-web-devicons', opt = true },
            -- --     },
            -- --     cmd = { 'VGit' },
            -- --     event = { 'BufRead' }
            -- -- }
            -- -- use telescope git_xxx
            -- -- { 'tpope/vim-fugitive', -- not lua
            -- --     cmd = { 'Git' }
            -- -- },
            -- -- { 'rbong/vim-flog', -- not lua
            -- --     -- config = function()
            -- --     -- end,
            -- --     cmd = { 'Flog' },
            -- --     keys = {},
            -- -- }
            --
            -- ----------------------------------------------------------------------
            -- --                              project                             --
            -- ----------------------------------------------------------------------
            -- -- TODO lazy load
            -- -- use { -- project
            -- --     { 'rcarriga/vim-ultest',
            -- --         requires = { 'vim-test.vim-test' },
            -- --         run = ':UpdateRemotePlugins',
            -- --         event = { 'BufRead' }
            -- --     },
            -- --     -- cmake
            -- --     { 'Shatur/neovim-cmake',
            -- --         -- cmd = { 'CMake' }
            -- --     }
            -- -- }
            -- -- use({
            -- -- 	"michaelb/sniprun",
            -- -- 	run = "bash install.sh",
            -- -- 	config = function()
            -- -- 		require("plugins.project.sniprun")
            -- -- 	end,
            -- -- 	cmd = { "SnipRun" },
            -- -- })
            --
            -- ----------------------------------------------------------------------
            -- --                              debug                               --
            -- ----------------------------------------------------------------------
            -- use({
            --     {
            --         "mfussenegger/nvim-dap",
            --         disable = true,
            --         module = "dap",
            --         config = function()
            --             require("plugins.debug.dap.dap-config")
            --         end,
            --         keys = {
            --             "<F5>",
            --             "<F6>",
            --         },
            --     },
            --     {
            --         "rcarriga/nvim-dap-ui",
            --         disable = true,
            --         config = function()
            --             require("plugins.debug.dap.dap-ui")
            --         end,
            --         after = { "nvim-dap" },
            --         opt = true,
            --     },
            --     {
            --         "theHamsta/nvim-dap-virtual-text",
            --         disable = true,
            --         config = function()
            --             require("plugins.debug.dap.nvim-dap-virtual-text")
            --         end,
            --         after = { "nvim-dap" },
            --     },
            --     {
            --         "sakhnik/nvim-gdb",
            --         disable = true,
            --         config = function()
            --             require("plugins.debug.nvim-gdb")
            --         end,
            --         run = "install.sh",
            --         keys = {
            --             "<F4>",
            --         },
            --         cmd = { "GdbStart", "GdbStartLLDB", "GdbStartPDB", "GdbStartBashDB" },
            --     },
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                             terminal                             --
            -- ----------------------------------------------------------------------
            -- use({
            --     "voldikss/vim-floaterm",
            --     config = function()
            --         require("plugins.terminal.vim-floaterm")
            --     end,
            --     keys = {
            --         "<m-=>",
            --         "<m-+>",
            --         "<leader>e",
            --     },
            --     cmd = { "FloatermNew" },
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                          editor support                          --
            -- ----------------------------------------------------------------------
            -- use({
            --     {
            --         "nvim-treesitter/nvim-treesitter",
            --         module_pattern = { "treesitter" },
            --         config = function()
            --             require("plugins.editor.nvim-treesitter")
            --         end,
            --         requires = {
            --             { "nvim-treesitter/nvim-treesitter-context", event = { "CursorMoved" } },
            --             { "windwp/nvim-ts-autotag", ft = { "html", "xml" }, event = { "InsertEnter" } }, -- <div> </div>
            --             { "p00f/nvim-ts-rainbow", event = { "CursorMoved" } },
            --         },
            --         event = { "InsertEnter", "CursorMoved", "WinScrolled" },
            --     },
            --     {
            --         "RRethy/vim-illuminate",
            --         config = function()
            --             require("plugins.editor.vim-illuminate")
            --         end,
            --         event = { "CursorMoved" },
            --     },
            --     { "p00f/nvim-ts-rainbow", after = { "nvim-treesitter" } },
            --     -- (|)
            --     -- {
            --     -- 	"windwp/nvim-autopairs",
            --     -- 	config = function()
            --     -- 		require("plugins.editor.nvim-autopairs")
            --     -- 	end,
            --     -- 	-- event = { 'InsertEnter' }
            --     -- 	after = { "nvim-cmp" },
            --     -- },
            --     -- {
            --     --     "m4xshen/autoclose.nvim",
            --     --     config = function()
            --     --         require("plugins.editor.autoclose")
            --     --     end,
            --     --     event = { "InsertEnter" },
            --     -- },
            --     {
            --         "echasnovski/mini.pairs",
            --         config = function()
            --             require("mini.pairs").setup({})
            --         end,
            --         event = "InsertEnter",
            --     },
            --     -- { 'jiangmiao/auto-pairs' },
            --     -- <div> </div>
            --     {
            --         "windwp/nvim-ts-autotag",
            --         ft = { "html", "xml" },
            --         requires = { "nvim-treesitter/nvim-treesitter" },
            --         config = function()
            --             -- require("plugins.editor.nvim-ts-autotag")
            --             require("nvim-ts-autotag").setup()
            --         end,
            --         event = { "InsertEnter" },
            --         -- event = { 'InsertEnter', 'CursorMoved', 'WinScrolled' }
            --     },
            --     {
            --         "phaazon/hop.nvim",
            --         config = function()
            --             require("plugins.editor.hop")
            --         end,
            --         -- cmd = { 'HopChar1' },
            --         keys = { "f", "F", "w" },
            --     },
            --     {
            --         "ur4ltz/surround.nvim",
            --         disable = true,
            --         config = function()
            --             require("plugins.editor.surround")
            --         end,
            --         keys = {
            --             { "n", "cs" },
            --             { "n", "ds" },
            --             { "n", "ys" },
            --         },
            --     },
            --     {
            --         "echasnovski/mini.surround",
            --         config = function()
            --             require("plugins.editor.mini-surround")
            --         end,
            --         keys = {
            --             { mode = "n", "cs" },
            --             { mode = "n", "ds" },
            --             { mode = "n", "ys" },
            --         },
            --     },
            --     { "tpope/vim-repeat", event = { "BufRead" } },
            --     -- not lua
            --     -- function end
            --     {
            --         "andymass/vim-matchup",
            --         config = function()
            --             require("plugins.editor.vim-matchup")
            --         end,
            --         requires = { "nvim-treesitter/nvim-treesitter" },
            --         event = { "CursorMoved" },
            --         -- event = { 'InsertEnter', 'CursorMoved', 'WinScrolled' }
            --     },
            --     {
            --         "lukas-reineke/indent-blankline.nvim",
            --         config = function()
            --             require("plugins.editor.indent-blankline")
            --         end,
            --         -- event = { 'BufRead' },
            --         cmd = {
            --             "IndentBlanklineToggle",
            --             "IndentBlanklineEnable",
            --             "IndentBlanklineRefresh",
            --         },
            --     },
            --     -- { 'petertriho/nvim-scrollbar',
            --     --     config = function()
            --     --         require('plugins.editor.nvim-scrollbar')
            --     --     end,
            --     --     requires = {
            --     --         { 'kevinhwang91/nvim-hlslens', opt = true }
            --     --     },
            --     --     event = { 'CursorMoved', 'WinScrolled', 'CmdlineChanged', 'CmdlineEnter' }
            --     -- },
            --     -- a scrollbar
            --     -- { 'lewis6991/satellite.nvim',
            --     --     config = function()
            --     --         require('plugins.editor.satellite')
            --     --     end,
            --     --     event = { 'CursorMoved', 'WinScrolled', 'CmdlineChanged', 'CmdlineEnter' }
            --     -- },
            --     {
            --         "kevinhwang91/nvim-hlslens",
            --         -- module_pattern = { "hlslens" },
            --         config = function()
            --             require("plugins.editor.nvim-hlslens")
            --         end,
            --         event = "SearchWrapped",
            --     },
            --     {
            --         "karb94/neoscroll.nvim",
            --         -- disable = true,
            --         config = function()
            --             require("plugins.editor.neoscroll")
            --         end,
            --         keys = {
            --             "<C-u>",
            --             "<C-d>",
            --             "<C-b>",
            --             "<C-f>",
            --             "<C-y>",
            --             "<C-e>",
            --             "zt",
            --             "zz",
            --             "zb",
            --         },
            --     },
            --     -- {
            --     -- 	"ethanholz/nvim-lastplace",
            --     -- 	config = function()
            --     -- 		require("plugins.editor.nvim-lastplace")
            --     -- 	end,
            --     -- 	event = { "BufRead" },
            --     -- },
            --     --  TODO: 如何去掉cmp的提示
            --     -- { 'filipdutescu/renamer.nvim',
            --     --     config = function()
            --     --         require('plugins.editor.renamer')
            --     --     end,
            --     --     requires = { { 'nvim-lua/plenary.nvim' } },
            --     --     keys = {
            --     --         { 'n', '<leader>rn' },
            --     --         { 'v', '<leader>rn' },
            --     --     }
            --     -- }
            --     {
            --         "mvllow/modes.nvim",
            --         tag = "v0.2.0",
            --         config = function()
            --             require("plugins.editor.modes")
            --         end,
            --         event = { "BufRead" },
            --     },
            --     -- {
            --     -- 	"abecodes/tabout.nvim",
            --     -- 	disable = true,
            --     -- 	config = function()
            --     -- 		require("plugins.editor.tabout")
            --     -- 	end,
            --     -- 	wants = { "nvim-treesitter" }, -- or require if not used so far
            --     -- 	-- after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
            --     -- 	event = { "InsertEnter" },
            --     -- },
            --     -- {
            --     -- 	"arnamak/stay-centered.nvim",
            --     -- 	config = function()
            --     -- 		require("stay-centered")
            --     -- 	end,
            --     -- 	event = "InsertEnter",
            --     -- },
            -- }) -- editor
            --
            -- ----------------------------------------------------------------------
            -- --                              window                              --
            -- ----------------------------------------------------------------------
            -- use({
            --     -- {
            --     -- 	"sindrets/winshift.nvim", -- move window
            --     -- 	config = function()
            --     -- 		require("plugins.windows.winshift")
            --     -- 	end,
            --     -- 	cmd = { "WinShift" },
            --     -- 	keys = {
            --     -- 		{ "n", "<c-w>m" },
            --     -- 		{ "n", "<c-w>s" },
            --     -- 	},
            --     -- },
            --     -- { 'https://gitlab.com/yorickpeterse/nvim-window.git',
            --     --     config = function()
            --     --         require('plugins.windows.nvim-window')
            --     --     end,
            --     --     keys = { '<c-w>-' }
            --     -- },
            --     {
            --         "s1n7ax/nvim-window-picker",
            --         config = function()
            --             require("plugins.windows.nvim-window-picker")
            --         end,
            --         keys = {
            --             { "n", "-" },
            --         },
            --     },
            --     -- {
            --     -- 	"beauwilliams/focus.nvim",
            --     -- 	config = function()
            --     -- 		require("plugins.windows.focus")
            --     -- 	end,
            --     -- 	cmd = { "FocusToggle", "FocusEnable" },
            --     -- 	keys = {
            --     -- 		{ "n", "<c-w>f" },
            --     -- 		{ "n", "<c-w>o" },
            --     -- 		{ "n", "<c-w>=" },
            --     -- 	},
            --     -- },
            --     -- support navigate and resize window
            --     -- copy, navigation, (resize window)
            --     {
            --         "aserowy/tmux.nvim",
            --         config = function()
            --             require("plugins.windows.tmux")
            --         end,
            --         -- event = { 'BufRead' },
            --         event = { "CursorMoved" }, -- is it reasonable?
            --         cond = function()
            --             return nil ~= os.getenv("TMUX")
            --         end,
            --     },
            --     -- { 'mrjones2014/smart-splits.nvim',
            --     {
            --         "fgheng/smart-splits.nvim",
            --         config = function()
            --             require("plugins.windows.smart-splits")
            --         end,
            --         keys = { "<c-w>r" },
            --     },
            --     {
            --         "nvim-zh/colorful-winsep.nvim",
            --         config = function()
            --             require("plugins.windows.colorful-winsep")
            --         end,
            --         event = { "WinNew" },
            --     },
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                             session                              --
            -- ----------------------------------------------------------------------
            -- -- use {
            -- -- TODO lazy load
            -- -- { 'Shatur/neovim-session-manager',
            -- --     config = function()
            -- --         require('plugins/neovim-session-manager')
            -- --     end,
            -- --     requires = { 'nvim-lua/plenary.nvim' },
            -- -- }
            -- -- }
            -- -- use { 'jedrzejboczar/possession.nvim',
            -- --     requires = { 'nvim-lua/plenary.nvim' },
            -- --     config = function()
            -- --         require('plugins.session.possession')
            -- --     end,
            -- -- }
            -- use({
            --     "folke/persistence.nvim",
            --     config = function()
            --         require("plugins.session.persistence")
            --     end,
            --     keys = {
            --         { "n", "<leader>qs" },
            --         { "n", "<leader>ql" },
            --         { "n", "<leader>qd" },
            --     },
            --     event = "BufReadPre", -- this will only start session saving when an actual file was opened
            -- })
            --
            -- ----------------------------------------------------------------------
            -- --                              utils                               --
            -- ----------------------------------------------------------------------
            -- -- use { 'Pocco81/AutoSave.nvim',
            -- --     config = function()
            -- --         require('plugins.utils.AutoSave')
            -- --     end,
            -- --     event = { 'InsertEnter' }
            -- -- }
            --
            -- use({
            --     {
            --         "nvim-lua/plenary.nvim",
            --         module = "plenary",
            --         -- event = { 'BufRead' }
            --     },
            --     {
            --         "SmiteshP/nvim-gps",
            --         module_pattern = { "gps", "nvim-gps" },
            --         config = function()
            --             require("plugins.utils.nvim-gps")
            --         end,
            --         requires = "nvim-treesitter/nvim-treesitter",
            --         event = { "InsertEnter", "CursorMoved" },
            --     },
            --     {
            --         "SmiteshP/nvim-navic",
            --         disable = true,
            --         pattern = { "nvim-navic" },
            --         event = { "InsertEnter", "CursorMoved" },
            --     },
            --     {
            --         "max397574/better-escape.nvim",
            --         config = function()
            --             require("plugins.utils.better-escape")
            --         end,
            --         event = { "InsertEnter" },
            --     },
            --     {
            --         "norcalli/nvim-colorizer.lua",
            --         config = function()
            --             require("plugins.utils.nvim-colorizer")
            --         end,
            --         cmd = { "ColorizerToggle" },
            --     },
            --     {
            --         "rcarriga/nvim-notify",
            --         opt = true,
            --         config = function()
            --             require("plugins.ui.nvim-notify")
            --             -- vim.notify = require('notify')
            --             -- vim.notify.setup({background_colour = "#282c34"})
            --         end,
            --         event = { "BufRead" },
            --     },
            --     { "dstein64/vim-startuptime", cmd = { "StartupTime" } },
            --     {
            --         "folke/todo-comments.nvim",
            --         requires = { "nvim-lua/plenary.nvim" },
            --         config = function()
            --             require("plugins.utils.todo-comments")
            --         end,
            --         -- event = { "BufRead" },
            --         keys = { "<space>t" },
            --     },
            --     --{
            --     -- 	"uga-rosa/translate.nvim",
            --     -- 	config = function()
            --     -- 		require("plugins.utils.translate")
            --     -- 	end,
            --     -- 	cmd = { "Translate" },
            --     -- 	keys = { ";t" },
            --     -- }
            -- })

            ----------------------------------------------------------------------
            --                              ui                               --
            ----------------------------------------------------------------------
            use({
                {
                    "kyazdani42/nvim-web-devicons",
                    config = function()
                        require("plugins.ui.theme.nvim-web-devicons")
                    end,
                    module_pattern = { "nvim-web-devicons*" },
                    -- event = { 'BufRead' }
                },
                {
                    "nvim-lualine/lualine.nvim",
                    module = "lualine",
                    config = function()
                        require("plugins.ui.lualine")
                    end,
                    requires = {
                        { "kyazdani42/nvim-web-devicons", opt = true },
                        { "arkav/lualine-lsp-progress" },
                    },
                    -- event = { 'InsertEnter', 'CursorMoved' }
                    event = { "BufRead" },
                },
                -- {
                --     "nvim-lua/lsp-status.nvim",
                --     -- module_pattern = "*lsp-status*",
                -- },
                {
                    "akinsho/bufferline.nvim",
                    disable = false,
                    config = function()
                        require("plugins.ui.bufferline")
                    end,
                    requires = { "kyazdani42/nvim-web-devicons", opt = true },
                    -- event = { 'InsertEnter', 'CursorMoved' }
                    event = { "BufAdd" },
                },
                {
                    "nanozuki/tabby.nvim",
                    disable = true,
                    config = function()
                        require("plugins.ui.tabby")
                    end,
                    event = { "BufAdd" },
                },
                {
                    "fgheng/winbar.nvim",
                    config = function()
                        require("plugins.ui.winbar")
                    end,
                    -- event = { 'InsertEnter', 'CursorMoved' }
                    event = { "BufReadPost" },
                },
            })

            -- ----------------------------------------------------------------------
            -- --                         themes                                   --
            -- ----------------------------------------------------------------------
            -- use({
            --     {
            --         "Mofiqul/vscode.nvim",
            --         config = function()
            --             vim.cmd([[colorscheme vscode]])
            --         end,
            --         cond = function()
            --             return require("config").colorscheme.theme_group == "vscode"
            --         end,
            --     },
            --     {
            --         "folke/tokyonight.nvim",
            --         config = function()
            --             require("plugins.ui.colorschemes.tokyonight")
            --         end,
            --         cond = function()
            --             return require("config").colorscheme.theme_group == "tokyonight"
            --         end,
            --     },
            --     {
            --         "kvrohit/mellow.nvim",
            --         config = function()
            --             require("plugins.ui.colorschemes.mellow")
            --         end,
            --         cond = function()
            --             return require("config").colorscheme.theme_group == "mellow"
            --         end,
            --     },
            --     {
            --         "catppuccin/nvim",
            --         name = "catppuccin",
            --         -- priority = 1000,
            --         config = function()
            --             vim.cmd([[colorscheme catppuccin]])
            --         end,
            --         cond = function()
            --             return require("config").colorscheme.theme_group == "catppuccin"
            --         end,
            --     },
            --     {
            --         "paulfrische/reddish.nvim",
            --         config = function()
            --             vim.cmd([[colorscheme reddish]])
            --         end,
            --         cond = function()
            --             return require("config").colorscheme.theme_group == "reddish"
            --         end,
            --     },
            --     {
            --         "LunarVim/horizon.nvim",
            --         config = function()
            --             vim.cmd([[colorscheme horizon]])
            --         end,
            --         cond = function()
            --             return require("config").colorscheme.theme_group == "horizon"
            --         end,
            --     },
            --     {
            --         "navarasu/onedark.nvim",
            --         priority = 1000,
            --         lazy = false,
            --         config = function()
            --             require("onedark").setup({
            --                 style = "deep",
            --             })
            --             require("onedark").load()
            --         end,
            --         cond = function()
            --             return require("config").colorscheme.theme_group == "onedark"
            --         end,
            --     },
            -- })

            ----------------------------------------------------------------------
            --                              custom                              --
            ----------------------------------------------------------------------

            -- packer auto install if packer is installed for the first time
            if packer_boot_strap then
                require("packer").sync()
            end
        end,
        config = { -- packer using float window
            display = {
                open_fn = function()
                    return require("packer.util").float({ border = "single" })
                end,
            },
        },
    })
end, 10)

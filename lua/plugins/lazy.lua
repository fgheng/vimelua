local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
        -- vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        ----------------------------------------------------------------------
        --                               lsp                                --
        ----------------------------------------------------------------------
        {
            "williamboman/mason.nvim",
            lazy = true,
            config = true,
        },
        {
            "neovim/nvim-lspconfig",
            config = function()
                require("plugins.lsp.nvim-lspconfig")
            end,
            dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
            -- event = { "InsertEnter" },
            event = { "BufReadPre", "BufNewFile" },
        },
        {
            -- "jose-elias-alvarez/null-ls.nvim",
            "nvimtools/none-ls.nvim",
            enabled = true,
            config = function()
                vim.schedule(function()
                    require("plugins.lsp.null-ls")
                end)
            end,
            dependencies = { "williamboman/mason.nvim", "jayp0521/mason-null-ls.nvim" },
            keys = {
                { mode = "n", "<leader>f" },
            },
            event = { "LspAttach" },
            -- event = {
            --     -- "CursorMoved",
            --     "InsertEnter",
            -- },
        },
        {
            "kosayoda/nvim-lightbulb",
            enabled = false,
            config = function()
                vim.schedule(function()
                    require("plugins.lsp.nvim-lightbulb")
                end)
            end,
            -- event = {
            --     "InsertEnter",
            --     "CursorMoved",
            -- },
            event = { "LspAttach" },
        },
        {
            "weilbith/nvim-code-action-menu",
            enabled = false, -- using dressing
            config = function()
                require("plugins.lsp.nvim-code-action-menu")
            end,
            dependencies = { "jose-elias-alvarez/null-ls.nvim" },
            cmd = "CodeActionMenu",
            keys = {
                { mode = "n", "ca" },
            },
        },
        {
            "filipdutescu/renamer.nvim",
            enabled = false, -- using dressing
            branch = "master",
            config = function()
                require("plugins.lsp.renamer")
            end,
            dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
            keys = {
                { mode = "n", "<leader>rn" },
            },
        },
        {
            "mfussenegger/nvim-jdtls",
            enabled = false,
            ft = { "java" },
            config = function()
                require("plugins.lsp.nvim-jdtls")
            end,
        },
        {
            -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            "fgheng/lsp_lines.nvim",
            enabled = false,
            config = function()
                require("plugins.lsp.lsp_lines")
            end,
            event = { "InsertEnter", "CursorMoved" },
        },
        -- 1. rename
        -- 2. code action
        -- 3. definition reference
        -- 4. hover
        -- 5. signature help
        -- 6. lightbulb
        -- 7. outline
        {
            "glepnir/lspsaga.nvim",
            enabled = false,
            config = function()
                vim.schedule(function()
                    require("plugins.lsp.lspsaga")
                end)
            end,
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
                --Please make sure you install markdown and markdown_inline parser
                { "nvim-treesitter/nvim-treesitter" },
            },
            -- event = "LspAttach",
        },

        {
            "hinell/lsp-timeout.nvim",
            enabled = false,
            config = function()
                vim.g.lspTimeoutConfig = {
                    stopTimeout = 1000, -- Stop unused lsp servers after 1s (for testing).
                    startTimeout = 2000, -- Force server restart if nvim can't in 2s.
                    silent = false, -- Notifications disabled
                    filetypes = { -- Exclude servers that miss behave on LSP stop/start.
                        ignore = { "markdown", "java" },
                    },
                }
            end,
            dependencies = { "neovim/nvim-lspconfig" },
            event = { "LspAttach" },
        },

        ----------------------------------------------------------------------
        --                            completion                            --
        ----------------------------------------------------------------------
        {
            "L3MON4D3/LuaSnip",
            lazy = true,
            config = function()
                require("plugins.completion.luasnip")
            end,
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
            -- event = "InsertEnter",
        },
        {
            "zbirenbaum/copilot.lua",
            enabled = true,
            config = function()
                vim.schedule(function()
                    require("plugins.completion.copilot")
                end)
            end,
            cmd = "Copilot",
            event = "InsertEnter",
        },
        {
            "hrsh7th/nvim-cmp",
            config = function()
                require("plugins.completion.nvim-cmp")
            end,
            dependencies = {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                -- "davidmh/cmp-nerdfonts",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                -- "zbirenbaum/copilot-cmp",
            },
            event = "InsertEnter",
        },
        {
            "Bryley/neoai.nvim",
            enabled = false,
            config = function()
                require("plugins.completion.neoai")
            end,
            dependencies = {
                "MunifTanjim/nui.nvim",
            },
            cmd = {
                "NeoAI",
                "NeoAIOpen",
                "NeoAIClose",
                "NeoAIToggle",
                "NeoAIContext",
                "NeoAIContextOpen",
                "NeoAIContextClose",
                "NeoAIInject",
                "NeoAIInjectCode",
                "NeoAIInjectContext",
                "NeoAIInjectContextCode",
            },
            keys = {
                { mode = "n", "<cr>" },
                { mode = "v", "<cr>" },
                { mode = "v", "<space>k" },
                { mode = "n", "<space>k" },
                { mode = "v", "<leader>as" },
                { mode = "n", "<leader>ag" },
            },
        },

        ----------------------------------------------------------------------
        --                             comment                              --
        ----------------------------------------------------------------------
        {
            "danymat/neogen", -- document generate
            config = function()
                require("plugins.comment.neogen")
            end,
            cmd = { "Neogen" },
            keys = {
                { mode = "n", "<leader>dd" },
                { mode = "n", "<leader>df" },
                { mode = "n", "<leader>dc" },
            },
        },
        {
            "numToStr/Comment.nvim", -- comment
            config = function()
                require("plugins.comment.Comment")
            end,
            keys = {
                { mode = "v", "<leader>cc" },
                { mode = "v", "<leader>cb" },
                { mode = "n", "<leader>cl" },
                { mode = "n", "<leader>bl" },
                { mode = "n", "<leader>co" },
                { mode = "n", "<leader>cO" },
                { mode = "n", "<leader>ca" },
            },
        },
        {
            "s1n7ax/nvim-comment-frame",
            config = function()
                require("plugins.comment.nvim-comment-frame")
            end,
            keys = {
                "<leader>dm",
                "<leader>dl",
            },
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
        },

        ----------------------------------------------------------------------
        --                           fuzzy_finder                           --
        ----------------------------------------------------------------------
        {
            "nvim-telescope/telescope.nvim",
            config = function()
                require("plugins.fuzzy_finder.telescope")
            end,
            dependencies = {
                { "nvim-lua/plenary.nvim" },
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                },
                { "nvim-telescope/telescope-live-grep-args.nvim" },
                { "nvim-telescope/telescope-symbols.nvim" },
                { "tsakirist/telescope-lazy.nvim" },
                -- { "nvim-telescope/telescope-ui-select.nvim" },
                -- { "cljoly/telescope-repo.nvim" },
            },
            cmd = { "Telescope" },
            keys = {
                { mode = "n", "<space><space>" },
                { mode = "n", "<space>f" },
                { mode = "n", "<space>s" },
                { mode = "v", "<space>s" },
                { mode = "n", "<space>g" },
                { mode = "n", "<space>b" },
                { mode = "n", "<space>a" },
                { mode = "n", "<space>r" },
                { mode = "n", "<space>j" },
                { mode = "n", "<space>o" },
                { mode = "v", "<space>o" },
                { mode = "n", "<space>O" },
                { mode = "v", "<space>O" },
                { mode = "n", "<space>/" },
                { mode = "v", "<space>/" },
                { mode = "n", "<space>?" },
                { mode = "v", "<space>?" },
            },
        },

        ----------------------------------------------------------------------
        --                         file and outline                         --
        ----------------------------------------------------------------------
        {
            "kyazdani42/nvim-tree.lua",
            enabled = false,
            config = function()
                require("plugins.file_explorer.nvim-tree")
            end,
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
            },
            cmd = { "NvimTreeOpen", "NvimTreeToggle" },
            keys = { "<F2>", "<leader>e" },
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            config = function()
                require("plugins.file_explorer.neo-tree")
            end,
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
            cmd = { "Neotree" },
            keys = {
                "<F2>",
                "<leader>e",
            },
        },
        {
            "stevearc/oil.nvim",
            enabled = false,
            config = function()
                require("plugins.file_explorer.oil")
            end,
            cmd = "Oil",
            keys = {
                "<leader>o",
                -- { "<space>e", "<cmd>Oil<cr>" },
            },
        },
        -- outline
        {
            "stevearc/aerial.nvim", -- lspconfig, lualine
            enabled = true,
            config = function()
                require("plugins.lsp.aerial")
            end,
            -- dependencies = {
            --     { "onsails/lspkind.nvim" },
            -- },
            cmd = { "AerialOpen", "AerialToggle" },
            keys = "<F3>",
        },
        -- {
        --     "simrat39/symbols-outline.nvim",
        --     enabled = false,
        --     config = function()
        --         require("plugins.lsp.symbols-outline")
        --     end,
        --     cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
        --     keys = { "<F3>" },
        -- },

        ----------------------------------------------------------------------
        --                               git                                --
        ----------------------------------------------------------------------
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                -- vim.defer_fn(function()
                --     require("plugins.git.gitsigns")
                -- end, 100)
                vim.schedule(function()
                    require("plugins.git.gitsigns")
                end)
            end,
            cmd = { "Gitsigns" },
            event = { "BufRead" },
            -- event = {"VeryLazy"}
        },
        {
            "sindrets/diffview.nvim",
            dependencies = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-tree/nvim-web-devicons" },
            },
            config = function()
                require("plugins.git.diffview")
            end,
            cmd = {
                "DiffviewOpen",
                "DiffviewLog",
                "DiffviewFileHistory",
            },
            keys = {
                { mode = "n", "<leader>gd" },
                -- { mode = "n", "<leader>gc" },
                { mode = "n", "<leader>gh" },
            },
        },

        ----------------------------------------------------------------------
        --                              project                             --
        ----------------------------------------------------------------------
        {
            "rcarriga/vim-ultest",
            enabled = false,
            dependencies = { "vim-test.vim-test" },
            build = ":UpdateRemotePlugins",
            event = { "BufRead" },
            -- event = {"VeryLazy"}
        },
        -- cmake
        {
            "Shatur/neovim-cmake",
            enabled = false,
            -- cmd = { 'CMake' }
        },
        {
            "michaelb/sniprun",
            enabled = false,
            build = "bash install.sh",
            config = function()
                require("plugins.project.sniprun")
            end,
            cmd = { "SnipRun" },
        },

        ----------------------------------------------------------------------
        --                              debug                               --
        ----------------------------------------------------------------------
        {
            "mfussenegger/nvim-dap",
            enabled = false,
            config = function()
                require("plugins.debug.dap.dap-config")
            end,
            keys = {
                "<F5>",
                "<F6>",
            },
        },
        {
            "rcarriga/nvim-dap-ui",
            enabled = false,
            config = function()
                require("plugins.debug.dap.dap-ui")
            end,
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            enabled = false,
            config = function()
                require("plugins.debug.dap.nvim-dap-virtual-text")
            end,
        },
        {
            "sakhnik/nvim-gdb",
            enabled = true,
            config = function()
                require("plugins.debug.nvim-gdb")
            end,
            -- build = "install.sh",
            keys = {
                "<F4>",
            },
            cmd = { "GdbStart", "GdbStartLLDB", "GdbStartPDB", "GdbStartBashDB" },
        },

        ----------------------------------------------------------------------
        --                             terminal                             --
        ----------------------------------------------------------------------
        {
            "voldikss/vim-floaterm",
            enabled = false,
            config = function()
                require("plugins.terminal.vim-floaterm")
            end,
            keys = {
                "<m-=>",
                "<m-+>",
            },
            cmd = { "FloatermNew" },
        },
        {
            "akinsho/toggleterm.nvim",
            -- tag = "*",
            config = function()
                require("plugins.terminal.toggleterm")
            end,
            keys = {
                { mode = "t", "<m-=>" },
                { mode = "n", "<m-=>" },
            },
        },
        {
            "chomosuke/term-edit.nvim",
            lazy = true,
            ft = { "toggleterm", "floaterm" },
            version = "1.*",
            config = function()
                require("plugins.editor.term-edit")
            end,
        },
        {
            "samjwill/nvim-unception",
            enabled = false,
            init = function() end,
            -- config = function ()
            --     require("unception").setup()
            -- end,
            -- event = { "TermOpen", "TermEnter" },
        },

        ----------------------------------------------------------------------
        --                          editor support                          --
        ----------------------------------------------------------------------
        {
            "famiu/bufdelete.nvim",
            cmd = { "Bdelete", "Bwipeout" },
        },
        {
            "gen740/SmoothCursor.nvim",
            enabled = true,
            config = function()
                vim.defer_fn(function()
                    require("plugins.editor.SmoothCursor")
                end, 100)
            end,
            event = { "CursorMoved" },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            enabled = true,
            config = function()
                -- vim.defer_fn(function()
                require("plugins.editor.nvim-treesitter")
                -- end, 10)
                -- vim.schedule(function()
                --     require("plugins.editor.nvim-treesitter")
                -- end)
            end,
            dependencies = {
                -- -- { "theHamsta/nvim-treesitter-pairs" },
                -- { "windwp/nvim-ts-autotag" }, -- <div> </div>
                -- -- { "kvim-treesitter/nvim-treesitter-textobjects" },
                -- { "mrjones2014/nvim-ts-rainbow" },
                { "nvim-treesitter/nvim-treesitter-context" },
                -- { "andymass/vim-matchup" },
            },
            -- event = { "BufReadPre" },
            event = { "CursorMoved", "InsertEnter" },
        },
        {
            "andymass/vim-matchup",
            enabled = false,
            lazy = true,
            config = function()
                vim.schedule(function()
                    require("plugins.editor.vim-matchup")
                end)
            end,
            -- event = { "CursorMoved" },
        },
        {
            "kawre/neotab.nvim",
            enabled = true,
            event = "InsertEnter",
            config = function()
                vim.schedule(function()
                    require("plugins.editor.neotab")
                end)
            end,
        },
        {
            "RRethy/vim-illuminate", -- highlight all world of current cursor in current buffer
            enabled = false,
            config = function()
                vim.defer_fn(function()
                    require("plugins.editor.vim-illuminate")
                end, 10)
            end,
            -- event = { "CursorMoved" },
            event = { "LspAttach" },
        },
        {
            "tzachar/local-highlight.nvim",
            enabled = false,
            config = function()
                require("local-highlight").setup({
                    file_types = { "python", "cpp" },
                })
            end,
            event = { "CursorMoved" },
        },
        -- (|)
        {
            "windwp/nvim-autopairs",
            enabled = false,
            config = function()
                require("plugins.editor.nvim-autopairs")
            end,
            event = { "InsertEnter" },
        },
        {
            "echasnovski/mini.pairs",
            config = function()
                require("mini.pairs").setup({})
            end,
            event = "InsertEnter",
        },
        {
            "phaazon/hop.nvim",
            branch = "v2",
            config = function()
                require("plugins.editor.hop")
            end,
            keys = { "f", "F", "W" },
        },
        {
            "ur4ltz/surround.nvim",
            enabled = true,
            config = function()
                require("plugins.editor.surround")
            end,
            keys = {
                { mode = "n", "cs" },
                { mode = "n", "ds" },
                { mode = "n", "ys" },
            },
        },
        {
            "echasnovski/mini.surround",
            enabled = false,
            config = function()
                require("plugins.editor.mini-surround")
            end,
            keys = {
                { mode = "n", "sr" },
                { mode = "n", "sd" },
                { mode = "n", "sa" },
                { mode = "n", "sh" },
                { mode = "n", "sF" },
                { mode = "n", "sf" },
                { mode = "v", "sa" },
            },
        },
        {
            "tpope/vim-repeat",
            event = { "CursorMoved" },
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            config = function()
                require("plugins.editor.indent-blankline")
            end,
            -- cmd = {
            --     "IndentBlanklineToggle",
            --     "IndentBlanklineEnable",
            --     "IndentBlanklineRefresh",
            -- },
            event = { "BufReadPost" },
        },
        {
            "petertriho/nvim-scrollbar",
            enabled = false,
            config = function()
                require("plugins.editor.nvim-scrollbar")
            end,
            dependencies = {
                { "kevinhwang91/nvim-hlslens" },
            },
            event = { "CursorMoved", "WinScrolled", "CmdlineChanged", "CmdlineEnter" },
        },
        -- a scrollbar
        {
            "lewis6991/satellite.nvim",
            enabled = false,
            config = function()
                require("plugins.editor.satellite")
            end,
            event = { "CursorMoved", "WinScrolled", "CmdlineChanged", "CmdlineEnter" },
        },
        {
            "kevinhwang91/nvim-hlslens",
            enabled = false, -- using noice
            config = function()
                require("plugins.editor.nvim-hlslens")
            end,
            event = "SearchWrapped",
        },
        {
            "karb94/neoscroll.nvim",
            enabled = true,
            config = function()
                require("plugins.editor.neoscroll")
            end,
            -- cond = function()
            --     return not vim.g.neovide
            -- end,
            keys = {
                "<C-u>",
                "<C-d>",
                "<C-b>",
                "<C-f>",
                "<C-y>",
                "<C-e>",
                "zt",
                "zz",
                "zb",
            },
        },
        {
            "ethanholz/nvim-lastplace",
            enabled = false,
            config = function()
                require("plugins.editor.nvim-lastplace")
            end,
            event = { "BufRead" },
            -- event = {"VeryLazy"}
        },
        {
            "mvllow/modes.nvim",
            enabled = true,
            tag = "v0.2.0",
            config = function()
                -- vim.defer_fn(function()
                --     require("plugins.editor.modes")
                -- end, 10)
                vim.schedule(function()
                    require("plugins.editor.modes")
                end)
            end,
            event = { "ModeChanged", "InsertEnter", "CursorMoved" },
        },
        {
            "abecodes/tabout.nvim",
            enabled = false,
            config = function()
                require("plugins.editor.tabout")
            end,
            dependencies = { "nvim-treesitter" }, -- or require if not used so far
            event = { "InsertEnter" },
        },
        {
            "arnamak/stay-centered.nvim",
            enabled = false,
            config = true,
            event = "InsertEnter",
        },

        ----------------------------------------------------------------------
        --                              window                              --
        ----------------------------------------------------------------------
        {
            "s1n7ax/nvim-window-picker",
            enabled = false,
            config = function()
                require("plugins.windows.nvim-window-picker")
            end,
            keys = {
                { mode = "n", "-" },
                -- { mode = "n", "<tab>" },
                -- { mode = "n", "<m-Tab>" }, -- ???
            },
        },
        {
            "aserowy/tmux.nvim",
            config = function()
                require("plugins.windows.tmux")
            end,
            cond = function()
                return nil ~= os.getenv("TMUX")
            end,
            event = { "CursorMoved" }, -- is it reasonable?
        },
        {
            "mrjones2014/smart-splits.nvim",
            enabled = true,
            config = function()
                require("plugins.windows.smart-splits")
            end,
            keys = {
                "<c-w>r",

                "<c-left>",
                "<c-down>",
                "<c-up>",
                "<c-right>",

                "<c-h>",
                "<c-j>",
                "<c-k>",
                "<c-l>",

                "<c-w>H",
                "<c-w>J",
                "<c-w>K",
                "<c-w>L",
            },
        },
        {
            "nvim-zh/colorful-winsep.nvim",
            enabled = false,
            config = function()
                require("plugins.windows.colorful-winsep")
            end,
            event = { "WinNew" },
        },

        ----------------------------------------------------------------------
        --                             session                              --
        ----------------------------------------------------------------------
        {
            "Shatur/neovim-session-manager",
            enabled = true,
            config = function()
                require("plugins.session.neovim-session-manager")
            end,
            event = "BufWritePost",
            cmd = "SessionManager",
            keys = {
                { mode = "n", "<leader>sl" },
            },
        },
        {
            "folke/persistence.nvim",
            enabled = false,
            config = function()
                require("plugins.session.persistence")
            end,
            keys = {
                {
                    mode = "n",
                    "<leader>ss",
                    desc = "Restore Session",
                },
                {
                    mode = "n",
                    "<leader>sl",
                    desc = "Restore Last Session",
                },
                {
                    mode = "n",
                    "<leader>sd",
                    desc = "Don't Save Current Session",
                },
            },
            event = "BufReadPre", -- this will only start session saving when an actual file was opened
        },
        {
            "rmagatti/auto-session",
            enabled = false,
            config = function()
                require("auto-session").setup({
                    log_level = "error",
                    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
                })
            end,
        },

        ----------------------------------------------------------------------
        --                               wiki                               --
        ----------------------------------------------------------------------
        {
            "nvim-neorg/neorg",
            enabled = true,
            run = ":Neorg sync-parsers", -- This is the important bit!
            ft = { "norg", "md", "markdown" },
            cmd = { "Neorg" },
            config = function()
                require("plugins.wiki.neorg")
            end,
            -- dependencies = {
            --     "john-cena/cool-neorg-plugin",
            -- },
        },
        {
            "nvim-orgmode/orgmode",
            enabled = false,
            ft = "org",
            config = function()
                require("plugins.wiki.orgmode")
            end,
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
        },

        ----------------------------------------------------------------------
        --                              utils                               --
        ----------------------------------------------------------------------
        {
            "nvim-lua/plenary.nvim",
            lazy = true,
        },
        {
            "rktjmp/lush.nvim",
            enabled = true,
            config = function()
                require("plugins.utils.lush")
            end,
            cmd = { "LushRunTutorial" },
        },
        {
            "kevinhwang91/nvim-ufo",
            enabled = false,
            dependencies = { "kevinhwang91/promise-async" },
            config = function()
                require("plugins.utils.nvim-ufo")
            end,
            event = { "LspAttach" },
        },
        {
            "Pocco81/AutoSave.nvim",
            enabled = false,
            config = function()
                require("plugins.utils.AutoSave")
            end,
            event = { "InsertEnter" },
        },
        {
            "SmiteshP/nvim-navic",
            enabled = false,
            lazy = true,
            -- init = function()
            --     require("utils").on_attach(function(client, buffer)
            --         if client.server_capabilities.documentSymbolProvider then
            --             require("nvim-navic").attach(client, buffer)
            --         end
            --     end)
            -- end,
            config = function()
                vim.defer_fn(function()
                    require("plugins.utils.nvim-navic")
                end, 10)
            end,
        },
        {
            "max397574/better-escape.nvim",
            config = function()
                require("plugins.utils.better-escape")
            end,
            event = { "InsertEnter" },
        },
        {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("plugins.utils.nvim-colorizer")
            end,
            cmd = { "ColorizerToggle" },
        },
        {
            "dstein64/vim-startuptime",
            cmd = { "StartupTime" },
        },
        {
            "folke/todo-comments.nvim",
            config = function()
                require("plugins.utils.todo-comments")
            end,
            dependencies = { "nvim-lua/plenary.nvim" },
            -- event = { "BufRead" },
            keys = { "<space>t" },
        },
        {
            "uga-rosa/translate.nvim",
            enabled = false,
            config = function()
                require("plugins.utils.translate")
            end,
            cmd = { "Translate" },
            keys = { { mode = "n", ";t" } },
        },
        {
            "potamides/pantran.nvim",
            enabled = true,
            config = function()
                require("plugins.utils.pantran")
            end,
            keys = {
                { mode = "n", "<leader>rr" },
                { mode = "x", "<leader>rr" },
            },
        },

        ----------------------------------------------------------------------
        --                              ui                               --
        ----------------------------------------------------------------------
        {
            "nvim-tree/nvim-web-devicons",
            lazy = true,
        },
        {
            "onsails/lspkind.nvim",
            enabled = false,
            lazy = true,
            config = function()
                require("plugins.ui.lspkind")
            end,
        },
        {
            "MunifTanjim/nui.nvim",
            lazy = true,
        },
        {
            "rcarriga/nvim-notify",
            enabled = true,
            lazy = true,
            config = function()
                if vim.g.neovide then
                    require("plugins.ui.nvim-notify")
                else
                    vim.defer_fn(function()
                        require("plugins.ui.nvim-notify")
                    end, 10)
                end
            end,
            -- event = { "BufRead" },
        },
        {
            -- 1. hover
            -- 2. signature help X
            -- 3. notify
            -- 4. cmdline searchline
            -- 5. renamer X
            -- 6. lsp progress X
            -- 7. search count
            -- 8. lualine noice-command, noice-mode
            -- 9. cmdline popup
            "folke/noice.nvim",
            enabled = true,
            config = function()
                require("plugins.ui.noice")
            end,
            requires = {
                "MunifTanjim/nui.nvim",
                -- "rcarriga/nvim-notify",
            },
            event = { "VeryLazy" },
        },
        {
            -- 1. telescope ui select
            -- 2. code action menu
            -- 3. renamer.nvim
            -- 4. input here
            "stevearc/dressing.nvim",
            enabled = true,
            init = function() -- this is fast
                vim.ui.select = function(...)
                    require("lazy").load({ plugins = { "dressing.nvim" } })
                    return vim.ui.select(...)
                end

                vim.ui.input = function(...)
                    require("lazy").load({ plugins = { "dressing.nvim" } })
                    return vim.ui.input(...)
                end
            end,
        },
        {
            "nvim-lualine/lualine.nvim",
            enabled = true,
            config = function()
                vim.schedule(function()
                    require("plugins.ui.lualine")
                end)
            end,
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
                { "arkav/lualine-lsp-progress" },
                -- { "SmiteshP/nvim-navic" },
            },
            -- event = { "BufRead" },
            event = { "VeryLazy" },
        },
        {
            "rebelot/heirline.nvim",
            enabled = false,
            config = function()
                require("plugins.ui.heirline")
            end,
            event = "VeryLazy",
        },
        {
            "akinsho/bufferline.nvim",
            enabled = true,
            config = function()
                vim.schedule(function()
                    require("plugins.ui.bufferline")
                end)
            end,
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
            -- event = { "WinNew" },
            -- event = { "BufAdd" },
            event = { "BufRead" },
            -- event = { "VeryLazy" },
        },
        {
            "luukvbaal/statuscol.nvim",
            enabled = true,
            config = function()
                vim.schedule(function()
                    require("plugins.ui.statuscol")
                end)
            end,
            event = { "BufReadPost" },
        },
        {
            "nanozuki/tabby.nvim",
            enabled = false,
            config = function()
                require("plugins.ui.tabby")
            end,
            event = { "BufAdd" },
        },
        {
            "fgheng/winbar.nvim",
            enabled = false,
            config = function()
                require("plugins.ui.winbar")
            end,
            dependencies = { "SmiteshP/nvim-gps" },
            event = { "BufReadPost" },
            -- event = { "VimEnter" },
            -- event = { "VeryLazy" },
        },

        ----------------------------------------------------------------------
        --                         themes                                   --
        ----------------------------------------------------------------------
        {
            "JoosepAlviste/palenightfall.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.defer_fn(function()
                    vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
                end, 10)
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "palenightfall.*") ~= nil
            end,
        },
        {
            "EdenEast/nightfox.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.defer_fn(function()
                    vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
                end, 10)
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "nightfox.*") ~= nil
            end,
        },
        {
            "HUAHUAI23/nvim-quietlight",
            priority = 1000,
            lazy = false,
            config = function()
                vim.defer_fn(function()
                    vim.opt.background = "light"
                    vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
                end, 10)
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "quietlight.*") ~= nil
            end,
        },
        {
            "Mofiqul/vscode.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.o.background = require("config").colorscheme.background
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "vscode.*") ~= nil
            end,
        },
        {
            "folke/tokyonight.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.schedule(function()
                    vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
                end)
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "tokyonight.*") ~= nil
            end,
        },
        {
            "kvrohit/mellow.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "mellow.*") ~= nil
            end,
        },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            lazy = false,
            config = function()
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "catppuccin.*") ~= nil
            end,
        },
        {
            "LunarVim/horizon.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "horizon.*") ~= nil
            end,
        },
        {
            "navarasu/onedark.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "onedark.*") ~= nil
            end,
        },
        {
            "olimorris/onedarkpro.nvim",
            priority = 1000, -- Ensure it loads first
            lazy = false,
            config = function()
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "onedarkpro.*") ~= nil
            end,
        },
        {
            "sainnhe/everforest",
            priority = 1000,
            lazy = false,
            config = function()
                -- vim.defer_fn(function()
                --     vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme_group))
                -- end, 1)
                -- vim.schedule(function()
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
                -- end)
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "everforest.*") ~= nil
            end,
        },
        {
            "sainnhe/sonokai",
            priority = 1000,
            lazy = false,
            config = function()
                -- vim.cmd([[colorscheme sonokai]])
                -- vim.cmd([[let g:sonokai_style = 'maia']])
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "sonokai.*") ~= nil
            end,
        },
        {
            "ray-x/starry.nvim",
            enabled = true,
            priority = 1000,
            lazy = false,
            config = function()
                vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
            end,
            cond = function()
                return string.match(require("config").colorscheme.theme_group, "starry.*") ~= nil
            end,
        },

        ----------------------------------------------------------------------
        --                              custom                              --
        ----------------------------------------------------------------------
        -- {
        --     "~/.config/nvim/lua/plugins/custom/"
        -- }
    },

    -- config
    {
        root = vim.fn.stdpath("data") .. "/lazy",
        defaults = {
            lazy = true, -- should plugins be lazy-loaded?
            version = "*",
            -- version = "*", -- enable this to try installing the latest stable versions of plugins
        },
        lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
        git = {
            -- defaults for the `Lazy log` command
            -- log = { "-10" }, -- show the last 10 commits
            log = { "--since=3 days ago" }, -- show commits from the last 3 days
            timeout = 120, -- kill processes that take more than 2 minutes
            url_format = "https://github.com/%s.git",
        },
        dev = {
            -- directory where you store your local plugin projects
            path = "~/projects",
            ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
            patterns = {}, -- For example {"folke"}
        },
        install = {
            -- install missing plugins on startup. This doesn't increase startup time.
            missing = true,
            -- try to load one of these colorschemes when starting an installation during startup
            colorscheme = { "habamax" },
        },
        checker = {
            -- automatically check for plugin updates
            enabled = true,
            concurrency = nil, ---@type number? set to 1 to check for updates very slowly
            notify = true, -- get a notification when new updates are found
            frequency = 3600, -- check for updates every hour
        },
        change_detection = {
            -- automatically check for config file changes and reload the ui
            enabled = true,
            notify = true, -- get a notification when changes are found
        },
        performance = {
            cache = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/lazy/cache",
                -- Once one of the following events triggers, caching will be disabled.
                -- To cache all modules, set this to `{}`, but that is not recommended.
                -- The default is to disable on:
                --  * VimEnter: not useful to cache anything else beyond startup
                --  * BufReadPre: this will be triggered early when opening a file from the command line directly
                disable_events = {},
                ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
            },
            reset_packpath = true, -- reset the package path to improve startup time
            rtp = {
                reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
                ---@type string[]
                paths = {}, -- add any custom paths here that you want to indluce in the rtp
                ---@type string[] list any plugins you want to disable here
                disabled_plugins = {
                    "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                    "netrw",
                    "netrwSettings",
                    "netrwFileHandlers",
                    "gzip",
                    "zip",
                    "tar",
                    "getscript",
                    "getscriptPlugin",
                    "vimball",
                    "vimballPlugin",
                    "2html_plugin",
                    "logipat",
                    "rrhelper",
                    "spellfile_plugin",
                    "man",
                    "tutor_mode_plugin",
                    "remote_plugins",
                    "shada_plugin",
                    "filetype",
                    "syntax",
                    "ftplugin",
                    "ftindent",
                    "spellfile",
                    "editorconfig",
                    "fzf",
                    "skim",
                },
            },
        },
        -- lazy can generate helptags from the headings in markdown readme files,
        -- so :help works even for plugins that don't have vim docs.
        -- when the readme opens with :help it will be correctly displayed as markdown
        readme = {
            root = vim.fn.stdpath("state") .. "/lazy/readme",
            files = { "README.md" },
            -- only generate markdown helptags for plugins that dont have docs
            skip_if_doc_exists = true,
        },
    }
)

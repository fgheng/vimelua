local fn = vim.fn
local cmd = vim.cmd

local packer_boot_strap = false
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_boot_strap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    if packer_boot_strap then
        cmd [[packadd packer.nvim]]
    else
        return
    end
end

-- TODO:
-- 1. make and run
-- 2. project
-- 3. session
-- 4. test

-- TODO: 开发
-- project
-- workspace
-- dict
--
-- learn how to lazy load telescope.extensions
-- loading the extension while using it really
--
-- learn telescope
-- write git hunks preview

pcall(require, 'impatient') -- run :LuaCacheClear

return require('packer').startup({ function(use)
    use { 'lewis6991/impatient.nvim' } -- to reduce loade time, run :LuaCacheClear
    use { 'wbthomason/packer.nvim' }

    ----------------------------------------------------------------------
    --                               lsp                                --
    ----------------------------------------------------------------------
    use {
        { 'neovim/nvim-lspconfig', -- need cmp-nvim-lsp, telescope
            module_pattern = { 'lspconfig.*' },
            config = function()
                require('plugins.lsp.nvim-lspconfig')
            end,
            event = { 'InsertEnter', 'CursorMoved' }
        },
        { 'williamboman/nvim-lsp-installer',
            -- need treesitter
            module = { 'nvim-lsp-installer', 'nvim_lsp_installer' },
            cmd = {
                'LspInstall',
                'LspInstallInfo',
                'LspUninstall',
                'LspUninstallAll',
                'LspInstallLog',
                'LspPrintInstalled'
            }
        },
        { 'kosayoda/nvim-lightbulb',
            config = function()
                require('plugins.lsp.nvim-lightbulb')
            end,
            event = { 'InsertEnter', 'CursorMoved' },
        },
    }

    ----------------------------------------------------------------------
    --                            completion                            --
    ----------------------------------------------------------------------
    use {
        { 'hrsh7th/nvim-cmp',
            module = { 'nvim-cmp', 'cmp' },
            config = function()
                require('plugins.completion.nvim-cmp')
            end,
            event = 'InsertEnter *'
        },
        -- snippets
        { 'L3MON4D3/LuaSnip', module = { 'luasnip', 'LuaSnip' } },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'rafamadriz/friendly-snippets', after = 'LuaSnip' },
        -- sources
        { 'hrsh7th/cmp-nvim-lsp', module_pattern = { 'cmp_nvim_lsp' } },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        -- { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },

        { 'github/copilot.vim',
            event = 'InsertEnter',
            config = function()
                require('plugins.completion.copilot')
            end
        }
    }

    ----------------------------------------------------------------------
    --                             comment                              --
    ----------------------------------------------------------------------
    use {
        { "danymat/neogen", -- document generate
            config = function()
                require('plugins.comment.neogen')
            end,
            requires = {
                { 'nvim-treesitter/nvim-treesitter' }
            },
            cmd = { 'Neogen' },
            keys = {
                { 'n', '<leader>dd' },
                { 'n', '<leader>df' },
                { 'n', '<leader>dc' }
            }
        },
        { 'numToStr/Comment.nvim', -- comment
            config = function()
                require('plugins.comment.Comment')
            end,
            keys = {
                '<leader>cc',
                '<leader>cb',
                '<leader>cl',
                '<leader>bl',
                '<leader>co',
                '<leader>cO',
                '<leader>ca'
            }
        },
        { 's1n7ax/nvim-comment-frame',
            config = function()
                require('plugins.comment.nvim-comment-frame')
            end,
            keys = {
                '<leader>dm',
                '<leader>dl',
            }
        }
    }

    ----------------------------------------------------------------------
    --                           fuzzy_finder                           --
    ----------------------------------------------------------------------
    use { 'nvim-telescope/telescope.nvim',
        module_pattern = 'telescope.*',
        config = function()
            require('plugins.fuzzy_finder.telescope')
        end,
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            -- { 'nvim-telescope/telescope-fzf-native.nvim',
            --     run = 'make',
            -- },
            -- { 'nvim-telescope/telescope-live-grep-raw.nvim'}
            -- { 'nvim-telescope/telescope-dap.nvim' }
        },
        cmd = { 'Telescope' },
        keys = {
            '<space><space>',
            '<space>f',
            '<space>s',
            '<space>b',
            '?',
            '<space>a',
            '<space>r',
            '<space>j'
        },
        after = { 'nvim-lsp-installer' }
    }

    ----------------------------------------------------------------------
    --                              lines                               --
    ----------------------------------------------------------------------
    use {
        { 'nvim-lualine/lualine.nvim',
            module = 'lualine',
            config = function()
                require('plugins.lines.lualine')
            end,
            requires = {
                { 'kyazdani42/nvim-web-devicons', opt = true },
            },
            -- event = { 'InsertEnter', 'CursorMoved' }
            event = { 'BufRead' }
        },
        { 'akinsho/bufferline.nvim',
            tag = "v2.*",
            config = function()
                require('plugins.lines.bufferline')
            end,
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            -- event = { 'InsertEnter', 'CursorMoved' }
            event = { 'BufRead' }
        },
        { 'SmiteshP/nvim-gps',
            module_pattern = { 'gps', 'nvim-gps' },
            config = function()
                require('plugins.lines.nvim-gps')
            end,
            requires = 'nvim-treesitter/nvim-treesitter',
            event = { 'InsertEnter', 'CursorMoved' },
        },
        { 'fgheng/winbar.nvim',
            config = function()
                require('plugins.lines.winbar')
            end,
            event = { 'InsertEnter', 'CursorMoved' }
        }
    }


    ----------------------------------------------------------------------
    --                         file and outline                         --
    ----------------------------------------------------------------------
    use {
        -- file mamager
        { 'kyazdani42/nvim-tree.lua',
            config = function()
                require('plugins.file_explorer.nvim-tree')
            end,
            requires = {
                { 'kyazdani42/nvim-web-devicons', opt = true }
            },
            cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
            keys = { '<F2>' }
        },
        -- outline
        { 'stevearc/aerial.nvim', -- lspconfig, lualine
            module_pattern = 'aerial',
            config = function()
                require('plugins.lsp.aerial')
            end,
            cmd = { 'AerialOpen', 'AerialToggle' },
            keys = '<F3>',
            -- event = { 'InsertEnter', 'CursorMoved' }
        },
        -- { 'simrat39/symbols-outline.nvim',
        --     config = function()
        --         require('plugins.lsp.symbols-outline')
        --     end,
        --     cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' },
        --     keys = { '<F3>' }
        -- }
    }

    ----------------------------------------------------------------------
    --                               git                                --
    ----------------------------------------------------------------------
    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('plugins.git.gitsigns')
        end,
        cmd = { 'Gitsigns' },
        event = { 'BufRead' }
    }
    -- use { 'tanvirtin/vgit.nvim',
    --     config = function()
    --         require('plugins.git.vgit')
    --     end,
    --     requires = {
    --         { 'nvim-lua/plenary.nvim' },
    --         { 'kyazdani42/nvim-web-devicons', opt = true },
    --     },
    --     cmd = { 'VGit' },
    --     event = { 'BufRead' }
    -- }
    -- use telescope git_xxx
    -- { 'tpope/vim-fugitive', -- not lua
    --     cmd = { 'Git' }
    -- },
    -- { 'rbong/vim-flog', -- not lua
    --     -- config = function()
    --     -- end,
    --     cmd = { 'Flog' },
    --     keys = {},
    -- }

    ----------------------------------------------------------------------
    --                              project                             --
    ----------------------------------------------------------------------
    -- TODO lazy load
    -- use { -- project
    --     { 'rcarriga/vim-ultest',
    --         requires = { 'vim-test.vim-test' },
    --         run = ':UpdateRemotePlugins',
    --         event = { 'BufRead' }
    --     },
    --     -- cmake
    --     { 'Shatur/neovim-cmake',
    --         -- cmd = { 'CMake' }
    --     }
    -- }
    use { 'michaelb/sniprun',
        run = 'bash install.sh',
        config = function()
            require('plugins.project.sniprun')
        end,
        cmd = { 'SnipRun' }
    }
    ----------------------------------------------------------------------
    --                              debug                               --
    ----------------------------------------------------------------------
    use {
        { 'mfussenegger/nvim-dap',
            module = 'dap',
            config = function()
                require('plugins.debug.dap.dap-config')
            end,
            keys = {
                '<F5>',
                '<F6>',
            }

        },
        { 'rcarriga/nvim-dap-ui',
            config = function()
                require('plugins.debug.dap.dap-ui')
            end,
            after = { 'nvim-dap' },
            opt = true
        },
        { 'theHamsta/nvim-dap-virtual-text',
            config = function()
                require('plugins.debug.dap.nvim-dap-virtual-text')
            end,
            after = { 'nvim-dap' }
        },
    }

    ----------------------------------------------------------------------
    --                             terminal                             --
    ----------------------------------------------------------------------
    use { 'voldikss/vim-floaterm',
        config = function()
            require('plugins.terminal.vim-floaterm')
        end,
        keys = {
            '<m-=>',
            '<m-+>',
            '<leader>e',
        },
        cmd = { 'FloatermNew' }
    }


    ----------------------------------------------------------------------
    --                          editor support                          --
    ----------------------------------------------------------------------
    use {
        { 'nvim-treesitter/nvim-treesitter',
            module_pattern = { 'treesitter' },
            config = function()
                require('plugins.editor.nvim-treesitter')
            end,
            event = { 'InsertEnter', 'CursorMoved', 'WinScrolled' }
        },
        { 'p00f/nvim-ts-rainbow',
            after = { 'nvim-treesitter' }
        },
        -- (|)
        { 'windwp/nvim-autopairs',
            config = function()
                require('plugins.editor.nvim-autopairs')
            end,
            -- event = { 'InsertEnter' }
            after = { 'nvim-cmp' }
        },
        -- { 'jiangmiao/auto-pairs' },
        -- <div> </div>
        { 'windwp/nvim-ts-autotag',
            ft = { 'html', 'xml' },
            requires = { 'nvim-treesitter/nvim-treesitter' },
            -- event = { 'InsertEnter' }
            -- event = { 'InsertEnter', 'CursorMoved', 'WinScrolled' }
        },
        { 'phaazon/hop.nvim',
            config = function()
                require('plugins.editor.hop')
            end,
            -- cmd = { 'HopChar1' },
            keys = { 'f', 'F', 'tl' }
        },
        { 'ur4ltz/surround.nvim',
            config = function()
                require('plugins.editor.surround')
            end,
            keys = {
                { 'n', 'cs' },
                { 'n', 'ds' },
                { 'n', 'ys' }
            }
        },
        { 'tpope/vim-repeat',
            event = { 'BufRead' }
        },
        -- not lua
        -- function end
        { 'andymass/vim-matchup',
            config = function()
                require('plugins.editor.vim-matchup')
            end,
            requires = { 'nvim-treesitter/nvim-treesitter' },
            event = { 'CursorMoved' }
            -- event = { 'InsertEnter', 'CursorMoved', 'WinScrolled' }
        },
        { 'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('plugins.editor.indent-blankline')
            end,
            -- event = { 'BufRead' },
            cmd = {
                'IndentBlanklineToggle',
                'IndentBlanklineEnable',
                'IndentBlanklineRefresh'
            }
        },
        { 'petertriho/nvim-scrollbar',
            config = function()
                require('plugins.editor.nvim-scrollbar')
            end,
            requires = {
                { 'kevinhwang91/nvim-hlslens', opt = true }
            },
            event = { 'CursorMoved', 'WinScrolled', 'CmdlineChanged', 'CmdlineEnter' }
        },
        { 'kevinhwang91/nvim-hlslens',
            module_pattern = { 'hlslens' },
            config = function()
                require('plugins.editor.nvim-hlslens')
            end,
        },
        { 'karb94/neoscroll.nvim',
            config = function()
                require('plugins.editor.neoscroll')
            end,
            keys = {
                '<C-u>',
                '<C-d>',
                '<C-b>',
                '<C-f>',
                '<C-y>',
                '<C-e>',
                'zt',
                'zz',
                'zb'
            },
        },
        --  TODO: 如何去掉cmp的提示
        -- { 'filipdutescu/renamer.nvim',
        --     config = function()
        --         require('plugins.editor.renamer')
        --     end,
        --     requires = { { 'nvim-lua/plenary.nvim' } },
        --     keys = {
        --         { 'n', '<leader>rn' },
        --         { 'v', '<leader>rn' },
        --     }
        -- }
    }

    ----------------------------------------------------------------------
    --                              window                              --
    ----------------------------------------------------------------------
    use {
        { 'sindrets/winshift.nvim',
            config = function()
                require('plugins.windows.winshift')
            end,
            cmd = { 'WinShift' },
            keys = { '=' }
        },
        { 'https://gitlab.com/yorickpeterse/nvim-window.git',
            config = function()
                require('plugins.windows.nvim-window')
            end,
            keys = { '-' }
        },
        -- { 'sunjon/shade.nvim', -- shade unactive window
        --     module = 'shade',
        --     config = function()
        --         require('plugins/windows/shade')
        --     end,
        --     event = { 'WinNew', 'WinEnter' }
        -- },
        -- { 'szw/vim-maximizer', -- not lua, conflict with shade
        --     config = function()
        --         require('plugins/windows/vim-maximizer')
        --     end,
        --     keys = { '<c-w>o' }
        -- },
        { 'nyngwang/NeoZoom.lua',
            -- branch = 'neo-zoom-original', -- UNCOMMENT THIS, if you prefer the old one
            config = function()
                require('plugins.windows.NeoZoom')
            end,
            cmd = { 'NeoZoomToggle' },
            keys = { '<c-w>o' }
        },
        -- support resize window, only use its maxsize
        -- { 'declancm/windex.nvim', -- conflict with shade
        --     config = function()
        --         require('plugins/windows/windex')
        --     end,
        --     keys = {
        --         '<c-w>o',
        --     }
        -- },
        -- support navigate and resize window
        -- copy, navigation, (resize window)
        { 'aserowy/tmux.nvim',
            config = function()
                require('plugins.windows.tmux')
            end,
            -- event = { 'BufRead' },
            event = { 'CursorMoved' }, -- is it resonable?
            cond = function() return nil ~= os.getenv('TMUX') end
        },
        -- { 'mrjones2014/smart-splits.nvim',
        { 'fgheng/smart-splits.nvim',
            config = function()
                require('plugins.windows.smart-splits')
            end,
            keys = { '<c-w>r' }
        }
    }

    ----------------------------------------------------------------------
    --                             session                              --
    ----------------------------------------------------------------------
    -- use {
    -- TODO lazy load
    -- { 'Shatur/neovim-session-manager',
    --     config = function()
    --         require('plugins/neovim-session-manager')
    --     end,
    --     requires = { 'nvim-lua/plenary.nvim' },
    -- }
    -- }
    -- use { 'jedrzejboczar/possession.nvim',
    --     requires = { 'nvim-lua/plenary.nvim' },
    --     config = function()
    --         require('plugins.session.possession')
    --     end,
    -- }


    ----------------------------------------------------------------------
    --                              utils                               --
    ----------------------------------------------------------------------
    use { 'Pocco81/AutoSave.nvim',
        config = function()
            require('plugins.utils.AutoSave')
        end,
        event = { 'InsertEnter' }
    }

    use { 'nvim-lua/plenary.nvim',
        module = 'plenary',
        -- event = { 'BufRead' }
    }

    use { 'norcalli/nvim-colorizer.lua',
        config = function()
            require('plugins.utils.nvim-colorizer')
        end,
        cmd = { 'ColorizerToggle' }
    }

    use { 'rcarriga/nvim-notify',
        opt = true,
        config = function()
            require('plugins.utils.nvim-notify')
            -- vim.notify = require('notify')
            -- vim.notify.setup({background_colour = "#282c34"})
        end,
        event = { 'VimEnter' }
    }

    use { 'dstein64/vim-startuptime',
        cmd = { 'StartupTime' }
    }

    use { 'folke/todo-comments.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plugins.utils.todo-comments')
        end,
        event = { 'BufRead' },
        keys = { '<space>t' }
    }

    ----------------------------------------------------------------------
    --                         theme and color                          --
    ----------------------------------------------------------------------
    use {
        { 'kyazdani42/nvim-web-devicons',
            config = function()
                require('plugins.theme.nvim-web-devicons')
            end,
            -- module_pattern = { 'nvim-web-devicons' }
            event = { 'BufRead' }
        },
        { 'ellisonleao/gruvbox.nvim',
            as = 'gruvbox',
            -- cond = config.colorscheme == 'gruvbox'
        },
        { 'sainnhe/gruvbox-material' },
        -- { 'marko-cerovac/material.nvim' },
        -- { 'rafamadriz/neon' },
        -- { 'ChristianChiarulli/nvcode-color-schemes.vim' },
        -- { 'sainnhe/sonokai' },
        -- { 'jim-at-jibba/ariake-vim-colors' },
        -- { 'ishan9299/modus-theme-vim' },
        { 'sainnhe/edge' },
        { 'Th3Whit3Wolf/one-nvim' },
        -- { 'Th3Whit3Wolf/space-nvim' },
        -- { 'olimorris/onedarkpro.nvim' },
        -- { 'LunarVim/darkplus.nvim' },
        -- { 'projekt0n/github-nvim-theme' },
        -- { 'NLKNguyen/papercolor-theme' },
        { 'rmehri01/onenord.nvim' },
        { 'catppuccin/nvim',
            -- cond = config.colorscheme == 'catppuccin',
        },
        { 'Mofiqul/vscode.nvim',
            -- cond = config.colorscheme == 'vscode'
        },
        { 'projekt0n/github-nvim-theme',
            -- cond = config.colorscheme == 'github'
        },
        { 'EdenEast/nightfox.nvim' }
    }

    ----------------------------------------------------------------------
    --                              custom                              --
    ----------------------------------------------------------------------

    -- packer auto install if packer is installed for the first time
    if packer_boot_strap then
        require('packer').sync()
    end
end,
config = { -- packer using float window
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
}
})

local map_to_themes = {
    default = function()
        return {}
    end,
    vscode = function()
        return {
            "Mofiqul/vscode.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                local c = require("vscode.colors").get_colors()
                require("vscode").setup({
                    -- Alternatively set style in setup
                    style = require("config").theme.style,

                    -- Enable transparent background
                    transparent = true,

                    -- Enable italic comment
                    italic_comments = true,

                    -- Disable nvim-tree background color
                    disable_nvimtree_bg = true,

                    -- Override colors (see ./lua/vscode/colors.lua)
                    -- color_overrides = {
                    --     vscLineNumber = "#FFFFFF",
                    -- },

                    -- Override highlight groups (see ./lua/vscode/theme.lua)
                    group_overrides = {
                        -- this supports the same val table as vim.api.nvim_set_hl
                        -- use colors from this colorscheme by requiring vscode.colors!
                        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
                        CursorLine = { bg = c.none },
                        WinBar = { fg = c.none, bg = c.none },
                        WinBarNC = { fg = c.none, bg = c.none },
                        StatusLine = { bg = c.none },
                    },
                })
                require("vscode").load()
                -- vim.cmd([[hi StatusLine guibg=NONE]])
            end,
        }
    end,
    everforest = function()
        return {
            "neanias/everforest-nvim",
            priority = 1000,
            lazy = false,
            config = function()
                require("everforest").setup({
                    background = "hard",
                    transparent_background_level = 2,
                    italics = true,
                    sign_column_background = "none",
                    ui_contrast = "high",
                    dim_inactive_windows = true,
                    on_highlights = function(hl, palette)
                        hl.WinBar = { fg = palette.bg, bg = "None" }
                        hl.WinBarNC = { fg = "None", bg = "None" }
                        hl.CursorLine = { fg = "None", bg = "None" }
                        hl.StatusLine = { bg = "None" }
                        hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
                        hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
                        hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
                        hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
                    end,
                })
                require("everforest").load()
            end,
        }
    end,

    nightfox = function()
        return {
            "EdenEast/nightfox.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                -- vim.api.nvim_command(string.format("colorscheme %s", require("config").theme.theme))
                local palette = require("nightfox.palette")
                require("nightfox").setup({
                    options = {
                        transparent = true,
                    },
                    groups = {
                        all = {
                            IncSearch = { bg = "palette.cyan" },
                            Cursor = { bg = "None" },
                            CursorLine = { bg = "None" },
                        },
                    },
                })
                require("nightfox").load()
            end,
        }
    end,
}

return map_to_themes[require("config").theme.theme]() or {}

-- local _M = {
--
--     {
--         "JoosepAlviste/palenightfall.nvim",
--         priority = 1000,
--         lazy = false,
--         config = function() end,
--         cond = function()
--             return string.match(require("config").theme.theme, "palenightfall.*") ~= nil
--         end,
--     },
--     {
--         "folke/tokyonight.nvim",
--         priority = 1000,
--         lazy = false,
--         config = function()
--             require("plugins.ui.colorschemes.tokyonight")
--             -- vim.schedule(function()
--             --     vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
--             -- end)
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "tokyonight.*") ~= nil
--         end,
--     },
--     {
--         "kvrohit/mellow.nvim",
--         priority = 1000,
--         lazy = false,
--         config = function()
--             vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "mellow.*") ~= nil
--         end,
--     },
--     {
--         "catppuccin/nvim",
--         name = "catppuccin",
--         priority = 1000,
--         lazy = false,
--         config = function()
--             require("plugins.ui.colorschemes.catppuccin")
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "catppuccin.*") ~= nil
--         end,
--     },
--     {
--         "LunarVim/horizon.nvim",
--         priority = 1000,
--         lazy = false,
--         config = function()
--             vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "horizon.*") ~= nil
--         end,
--     },
--     {
--         "navarasu/onedark.nvim",
--         priority = 1000,
--         lazy = false,
--         config = function()
--             require("plugins.ui.colorschemes.onedark")
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "onedark.*") ~= nil
--         end,
--     },
--     {
--         "olimorris/onedarkpro.nvim",
--         priority = 1000, -- Ensure it loads first
--         lazy = false,
--         config = function()
--             vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "onedarkpro.*") ~= nil
--         end,
--     },
--     {
--         "sainnhe/sonokai",
--         priority = 1000,
--         lazy = false,
--         config = function()
--             -- vim.cmd([[colorscheme sonokai]])
--             -- vim.cmd([[let g:sonokai_style = 'maia']])
--             vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "sonokai.*") ~= nil
--         end,
--     },
--     {
--         "ray-x/starry.nvim",
--         enabled = true,
--         priority = 1000,
--         lazy = false,
--         config = function()
--             vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "starry.*") ~= nil
--         end,
--     },
--     {
--         "alexmozaidze/palenight.nvim",
--         bled = true,
--         priority = 1000,
--         lazy = false,
--         config = function()
--             vim.api.nvim_command(string.format("colorscheme %s", require("config").colorscheme.theme))
--         end,
--         cond = function()
--             return string.match(require("config").theme.theme, "palenight.*") ~= nil
--         end,
--     },
-- }
-- return _M

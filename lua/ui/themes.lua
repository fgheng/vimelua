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
                vim.opt.winblend = 50
                local c = require("vscode.colors").get_colors()
                require("vscode").setup({
                    -- Alternatively set style in setup
                    style = require("config").theme.background,

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
                        NormalFloat = { bg = c.none },
                        FloatBorder = { fg = c.none, bg = c.none },
                    },
                })
                require("vscode").load()
            end,
        }
    end,
    everforest = function()
        return {
            "neanias/everforest-nvim",
            priority = 1000,
            lazy = false,
            config = function()
                vim.opt.winblend = 50
                require("everforest").setup({
                    background = "hard",
                    transparent_background_level = 5,
                    italics = true,
                    sign_column_background = "none",
                    ui_contrast = "high",
                    dim_inactive_windows = true,
                    on_highlights = function(hl, palette)
                        hl.WinBar = { fg = palette.bg, bg = "None" }
                        hl.WinBarNC = { fg = "None", bg = "None" }
                        hl.CursorLine = { fg = "None", bg = "None" }
                        hl.StatusLine = { bg = "None" }
                        hl.StatusLineNC = { bg = "None" }
                        hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
                        hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
                        hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
                        hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
                        hl.NormalFloat = { bg = "None" }
                        hl.FloatBorder = { fg = "None", bg = "None" }
                        hl.TabLine = { bg = "None" }
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
                vim.opt.winblend = 50
                require("nightfox").setup({
                    options = {
                        -- Compiled file's destination location
                        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                        compile_file_suffix = "_compiled", -- Compiled file suffix
                        transparent = true, -- Disable setting background
                        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                        dim_inactive = false, -- Non focused panes set to alternative background
                        module_default = true, -- Default enable value for modules
                        colorblind = {
                            enable = false, -- Enable colorblind support
                            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
                            severity = {
                                protan = 0, -- Severity [0,1] for protan (red)
                                deutan = 0, -- Severity [0,1] for deutan (green)
                                tritan = 0, -- Severity [0,1] for tritan (blue)
                            },
                        },
                        styles = { -- Style to be applied to different syntax groups
                            comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
                            conditionals = "NONE",
                            constants = "NONE",
                            functions = "NONE",
                            keywords = "NONE",
                            numbers = "NONE",
                            operators = "NONE",
                            strings = "NONE",
                            types = "NONE",
                            variables = "NONE",
                        },
                        inverse = { -- Inverse highlight for different types
                            match_paren = false,
                            visual = false,
                            search = false,
                        },
                        modules = { -- List of various plugins and additional options
                            -- ...
                        },
                    },
                    palettes = {},
                    specs = {},
                    groups = {
                        all = {
                            WinBar = { bg = "None" },
                            WinBarNC = { fg = "None", bg = "None" },
                            CursorLine = { fg = "None", bg = "None" },
                            StatusLine = { bg = "None" },
                            NormalFloat = { bg = "None" },
                        },
                    },
                })

                require("nightfox").load()
                -- -- setup must be called before loading
                -- vim.cmd("colorscheme nightfox")
            end,
        }
    end,
}

return map_to_themes[require("config").theme.theme]() or {}

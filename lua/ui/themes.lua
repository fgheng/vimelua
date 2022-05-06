vim.opt.winblend = 50
vim.opt.pumblend = 20

local function set_highlights()
    local colors = require("utils.colors")
    vim.api.nvim_set_hl(0, "St_NormalMode", { fg = colors.black, bg = colors.cyan })
    vim.api.nvim_set_hl(0, "St_VisualMode", { fg = colors.black, bg = colors.red })
    vim.api.nvim_set_hl(0, "St_InsertMode", { fg = colors.black, bg = colors.green })
    vim.api.nvim_set_hl(0, "St_TerminalMode", { fg = colors.black, bg = colors.fg })
    vim.api.nvim_set_hl(0, "St_ReplaceMode", { fg = colors.black, bg = colors.magenta })
    vim.api.nvim_set_hl(0, "St_SelectMode", { fg = colors.black, bg = colors.yellow })
    vim.api.nvim_set_hl(0, "St_CommandMode", { fg = colors.black, bg = colors.blue })
    -- vim.api.nvim_set_hl(0, "St_Text", { fg = colors.black, bg = "none"})
    vim.api.nvim_set_hl(0, "St_Branch", { fg = colors.green, bg = "none" })
    vim.api.nvim_set_hl(0, "St_Error", { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0, "St_Warning", { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0, "St_Info", { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0, "St_Hint", { link = "diagnosticHint" })

    vim.api.nvim_set_hl(0, "St_GitAdd", { link = "GitSignsAdd" })
    vim.api.nvim_set_hl(0, "St_GitMod", { link = "GitSignsChange" })
    vim.api.nvim_set_hl(0, "St_GitDel", { link = "GitSignsDelete" })
end

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
                    style = require("config").ui.theme.background,

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
                        CursorLine = { bg = "#4a4b4a" },
                        WinBar = { fg = c.none, bg = c.none },
                        WinBarNC = { fg = c.none, bg = c.none },
                        StatusLine = { bg = c.none },
                        StatusLineNC = { bg = c.none },
                        NormalFloat = { bg = c.none },
                        FloatBorder = { fg = c.none, bg = c.none },
                    },
                })
                require("vscode").load()
                set_highlights()
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
                    transparent_background_level = 5,
                    italics = true,
                    sign_column_background = "none",
                    ui_contrast = "high",
                    dim_inactive_windows = true,
                    on_highlights = function(hl, palette)
                        hl.WinBar = { fg = palette.bg, bg = "None" }
                        hl.WinBarNC = { fg = "None", bg = "None" }
                        -- hl.CursorLine = { bg = "None" }
                        hl.StatusLine = { bg = "None" }
                        hl.StatusLineNC = { bg = "None" }
                        hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
                        hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
                        hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
                        hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
                        hl.NormalFloat = { bg = "None" }
                        hl.FloatBorder = { fg = "None", bg = "None" }
                        hl.TabLine = { bg = "None" }
                        hl.WinSeparator = { fg = palette.bg, bg = "None" }
                    end,
                })
                require("everforest").load()
                set_highlights()
            end,
        }
    end,

    nightfox = function()
        return {
            "EdenEast/nightfox.nvim",
            priority = 1000,
            lazy = false,
            config = function()
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
                set_highlights()
            end,
        }
    end,
    cyberdream = function()
        return {
            "scottmckendry/cyberdream.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("cyberdream").setup({
                    -- Recommended - see "Configuring" below for more config options
                    transparent = true,
                    italic_comments = true,
                    hide_fillchars = false,
                    borderless_telescope = false,
                    theme = {
                        highlights = {
                            WinBar = { fg = "None", bg = "None" },
                            WinBarNC = { fg = "None", bg = "None" },
                            CursorLine = { fg = "None", bg = "None" },
                            StatusLine = { bg = "None" },
                            StatusLineNC = { bg = "None" },
                            NormalFloat = { bg = "None" },
                            FloatBorder = { fg = "None", bg = "None" },
                            TabLine = { bg = "None" },
                            WinSeparator = { bg = "None" },
                        },
                    },
                })
                vim.cmd.colorscheme("cyberdream") -- set the colorscheme
                set_highlights()
            end,
        }
    end,
    github = function()
        return {
            "projekt0n/github-nvim-theme",
            lazy = false, -- make sure we load this during startup if it is your main colorscheme
            priority = 1000, -- make sure to load this before all the other start plugins
            config = function()
                require("github-theme").setup({
                    options = {
                        transparent = false,
                    },
                    groups = {
                        -- ...
                        -- As with specs and palettes, the values defined under `all` will be applied to every style.
                        all = {
                            -- If `link` is defined it will be applied over any other values defined
                            Whitespace = { link = "Comment" },

                            -- Specs are used for the template. Specs have their palette's as a field that can be accessed
                            IncSearch = { bg = "palette.cyan" },
                            StatusLine = { bg = "None" },
                        },
                        github_dark = {
                            -- As with specs and palettes, a specific style's value will be used over the `all`'s value.
                            PmenuSel = { bg = "#73daca", fg = "bg0" },
                        },
                    },
                })

                -- vim.cmd("colorscheme github_light_colorblind")
                vim.cmd.colorscheme("github_dark_colorblind")
                set_highlights()
            end,
        }
    end,
    ["melange"] = function()
        return {
            "savq/melange-nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.opt.termguicolors = true
                vim.cmd.colorscheme("melange")
                set_highlights()
            end,
        }
    end,
    rosepine = function()
        return {
            "rose-pine/neovim",
            name = "rose-pine",
            lazy = false,
            priority = 1000,
            config = function()
                require("rose-pine").setup({
                    variant = "auto", -- auto, main, moon, or dawn
                    dark_variant = "main", -- main, moon, or dawn
                    dim_inactive_windows = false,
                    extend_background_behind_borders = true,

                    enable = {
                        terminal = true,
                        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                        migrations = true, -- Handle deprecated options automatically
                    },

                    styles = {
                        bold = true,
                        italic = true,
                        transparency = true,
                    },

                    groups = {
                        border = "muted",
                        link = "iris",
                        panel = "surface",

                        error = "love",
                        hint = "iris",
                        info = "foam",
                        note = "pine",
                        todo = "rose",
                        warn = "gold",

                        git_add = "foam",
                        git_change = "rose",
                        git_delete = "love",
                        git_dirty = "rose",
                        git_ignore = "muted",
                        git_merge = "iris",
                        git_rename = "pine",
                        git_stage = "iris",
                        git_text = "rose",
                        git_untracked = "subtle",

                        h1 = "iris",
                        h2 = "foam",
                        h3 = "rose",
                        h4 = "gold",
                        h5 = "pine",
                        h6 = "foam",
                    },

                    highlight_groups = {
                        -- Comment = { fg = "foam" },
                        -- VertSplit = { fg = "muted", bg = "muted" },
                        WinBar = { fg = "None", bg = "None" },
                        WinBarNC = { fg = "None", bg = "None" },
                        CursorLine = { fg = "None", bg = "None" },
                        StatusLine = { bg = "None" },
                        StatusLineNC = { bg = "None" },
                        NormalFloat = { bg = "None" },
                        FloatBorder = { fg = "None", bg = "None" },
                        TabLine = { bg = "None" },
                        WinSeparator = { bg = "None" },
                    },

                    before_highlight = function(group, highlight, palette)
                        -- Disable all undercurls
                        -- if highlight.undercurl then
                        --     highlight.undercurl = false
                        -- end
                        --
                        -- Change palette colour
                        -- if highlight.fg == palette.pine then
                        --     highlight.fg = palette.foam
                        -- end
                    end,
                })

                -- vim.cmd("colorscheme rose-pine-main")
                -- vim.cmd("colorscheme rose-pine-dawn")
                vim.cmd("colorscheme rose-pine-moon")
                set_highlights()
            end,
        }
    end,
    paper = function()
        return {
            "yorik1984/newpaper.nvim",
            priority = 1000,
            lazy = false,
            config = function()
                local style = require("config").ui.theme.style
                require("newpaper").setup({
                    style = style,
                })
            end,
        }
    end,
}

return map_to_themes[require("config").ui.theme.theme]() or {}

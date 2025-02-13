local _M = {
    {
        "L3MON4D3/LuaSnip",
        -- lazy = true,
        event = "InsertEnter",
        build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local luasnip = require("luasnip")

            luasnip.config.set_config({
                history = true,
            })

            -- load default snippets
            require("luasnip.loaders.from_vscode").lazy_load()
            -- load custom snippets
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = {
                    require("config").snippet_path,
                },
            })

            luasnip.filetype_extend("typescript", { "tsdoc" })
            luasnip.filetype_extend("javascript", { "jsdoc" })
            luasnip.filetype_extend("lua", { "luadoc" })
            luasnip.filetype_extend("python", { "pydoc" })
            luasnip.filetype_extend("rust", { "rustdoc" })
            luasnip.filetype_extend("cs", { "csharpdoc" })
            luasnip.filetype_extend("java", { "javadoc" })
            luasnip.filetype_extend("c", { "cdoc" })
            luasnip.filetype_extend("cpp", { "cppdoc" })
            luasnip.filetype_extend("php", { "phpdoc" })
            luasnip.filetype_extend("kotlin", { "kdoc" })
            luasnip.filetype_extend("ruby", { "rdoc" })
            luasnip.filetype_extend("sh", { "shelldoc" })
        end,
        -- keys = {
        --     {
        --         mode = { "i" },
        --         "<M-j>",
        --         function()
        --             local luasnip = require("luasnip")
        --             if luasnip.jumpable(1) then
        --                 luasnip.jump(1)
        --             end
        --         end,
        --         desc = "Jump forward",
        --     },
        --     {
        --         mode = { "i" },
        --         "<M-k>",
        --         function()
        --             local luasnip = require("luasnip")
        --             if luasnip.jumpable(-1) then
        --                 luasnip.jump(-1)
        --             end
        --         end,
        --         desc = "Jump backward",
        --     },
        -- },
    },

    {
        "chrisgrieser/nvim-scissors",
        dependencies = "nvim-telescope/telescope.nvim",
        opts = {
            snippetDir = require("config").snippet_path,
            editSnippetPopup = {
                height = require("config").ui.float_ui_win.height,
                width = require("config").ui.float_ui_win.width,
                border = require("config").ui.float_ui_win.border,
                keymaps = {
                    -- if not mentioned otherwise, the keymaps apply to normal mode
                    cancel = "q",
                    saveChanges = "<CR>", -- alternatively, can also use `:w`
                    goBackToSearch = "<BS>",
                    deleteSnippet = "<C-BS>",
                    duplicateSnippet = "<C-d>",
                    openInFile = "<C-o>",
                    insertNextPlaceholder = "<C-p>", -- insert & normal mode
                    showHelp = "?",
                },
            },
            telescope = {
                -- By default, the query only searches snippet prefixes. Set this to
                -- `true` to also search the body of the snippets.
                alsoSearchSnippetBody = true,

                -- accepts the common telescope picker config
                opts = {
                    layout_strategy = "bottom_pane",
                    layout_config = {
                        -- horizontal = { width = 0.9 },
                        -- preview_width = 0.6,
                        height = 0.3,
                        -- width = { 0.4, max = 100, min = 60 },
                        mirror = false,
                        prompt_position = "top",
                    },
                },
            },

            -- `none` writes as a minified json file using `vim.encode.json`.
            -- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
            -- you version control your snippets. To use a custom formatter, set to a
            -- list of strings, which will then be passed to `vim.system()`.
            ---@type "yq"|"jq"|"none"|string[]
            jsonFormatter = "none",

            backdrop = {
                enabled = true,
                blend = 50, -- between 0-100
            },
            icons = {
                scissors = "󰩫",
            },
        },
        keys = {
            {
                mode = "n",
                "<leader>se",
                function()
                    require("scissors").editSnippet()
                end,
                desc = "Edit snippet",
            },
            {
                mode = { "n", "x" },
                "<leader>sa",
                function()
                    require("scissors").addNewSnippet()
                end,
                desc = "Add snippet",
            },
        },
    },
}
return _M

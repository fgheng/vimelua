local _M = {
    {
        "danymat/neogen", -- document generate
        cmd = { "Neogen" },
        opts = {
            enabled = true,
            snippet_engine = "luasnip",
        },
        keys = {
            { mode = "n", "<leader>dd", "<cmd>lua require('neogen').generate()<cr>", desc = "Generate Documentation" },
            {
                mode = "n",
                "<leader>df",
                "<cmd>lua require('neogen').generate({type = 'func'})<cr>",
                desc = "Generate Function Documentation",
            },
            {
                mode = "n",
                "<leader>dc",
                "<cmd>lua require('neogen').generate({type = 'class'})<cr>",
                desc = "Generate Class Documentation",
            },
        },
    },
    {
        "LudoPinelli/comment-box.nvim",
        cmd = {
            "CBllbox",
            "CBlrbox",
            "CBlcbox",
            "CBcatalog",
        },
    },
    {
        "numToStr/Comment.nvim", -- comment
        opts = {
            padding = true,
            sticky = true,
            ignore = nil,

            toggler = {
                line = "<leader>cl",
                block = "<leader>bl",
            },

            opleader = {
                line = "<leader>cc",
                block = "<leader>cb",
            },

            extra = {
                above = "<leader>cO",
                below = "<leader>co",
                eol = "<leader>ca",
            },

            ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
            ---NOTE: If `mappings = false` then the plugin won't create any mappings
            ---@type boolean|table
            mappings = {
                ---Operator-pending mapping
                ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
                ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
                basic = true,
                ---Extra mapping
                ---Includes `gco`, `gcO`, `gcA`
                extra = true,
                ---Extended mapping
                ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
                extended = false,
            },

            pre_hook = nil,
            post_hook = nil,
        },
        keys = {
            { mode = "v", "<leader>cc", desc = "Toggle Comment lines" },
            { mode = "v", "<leader>cb", desc = "Toggle Comment block" },
            { mode = "n", "<leader>cl", desc = "Toggle Comment lines" },
            { mode = "n", "<leader>bl", desc = "Toggle Comment block" },
            { mode = "n", "<leader>co", desc = "Toggle Comment below"},
            { mode = "n", "<leader>cO", desc = "Toggle Comment above"},
            { mode = "n", "<leader>ca", desc = "Toggle Comment at end of line"},
        },
    },
    {
        "s1n7ax/nvim-comment-frame",
        enabled = true,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- if true, <leader>cf keymap will be disabled
            disable_default_keymap = false,

            -- -- adds custom keymap
            -- keymap = '<leader>df',
            -- multiline_keymap = '<leader>dm',

            -- start the comment with this string
            -- start_str = '//',

            -- end the comment line with this string
            -- end_str = '//',

            -- fill the comment frame border with this character
            -- fill_char = '-',

            -- width of the comment frame
            -- frame_width = 70,

            -- wrap the line after 'n' characters
            -- line_wrap_len = 50,

            -- automatically indent the comment frame based on the line
            auto_indent = true,

            -- add comment above the current line
            add_comment_above = true,

            -- configurations for individual language goes here
            languages = {},
        },
        keys = {
            {
                mode = "n",
                "<leader>dl",
                "<cmd>lua require('nvim-comment-frame').add_comment()<cr>",
                desc = "Add comment",
            },
            {
                mode = "n",
                "<leader>dm",
                "<cmd>lua require('nvim-comment-frame').add_multiline_comment()<cr>",
                desc = "Add multiline comment",
            },
        },
    },
}
return _M

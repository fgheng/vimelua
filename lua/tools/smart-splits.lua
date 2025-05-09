local _M = {
    "mrjones2014/smart-splits.nvim",
    enabled = false,
    opts = {
        -- Ignored filetypes (only while resizing)
        ignored_filetypes = {
            "nofile",
            "qf",
            "quickfix",
            "prompt",
        },
        -- Ignored buffer types (only while resizing)
        ignored_buftypes = {
            "nofile",
        },
        -- when moving cursor between splits left or right,
        -- place the cursor on the same row of the *screen*
        -- regardless of line numbers. False by default.
        -- Can be overridden via function parameter, see Usage.
        move_cursor_same_row = false,
        default_amount = 2,
        resize_mode = {
            -- key to exit persistent resize mode
            quit_key = "<ESC>",
            -- keys to use for moving in resize mode
            -- in order of left, down, up' right
            resize_keys = { "h", "j", "k", "l" },
            -- set to true to silence the notifications
            -- when entering/exiting persistent resize mode
            silent = false,
            -- must be functions, they will be executed when
            -- entering or exiting the resize mode
            hooks = {
                on_enter = nil,
                on_leave = nil,
            },
        },
    },
    keys = {
        {
            mode = "n",
            "<C-w>r",
            function()
                require("smart-splits").start_resize_mode()
            end,
        },
        -- { mode = "n", "<c-left>", '<cmd>lua require("smart-splits").resize_left()<cr>' },
        -- { mode = "n", "<c-down>", '<cmd>lua require("smart-splits").resize_down()<cr>' },
        -- { mode = "n", "<c-up>", '<cmd>lua require("smart-splits").resize_up()<cr>' },
        -- { mode = "n", "<c-right>", '<cmd>lua require("smart-splits").resize_right()<cr>' },
        { mode = "n", "<C-h>", '<cmd>lua require("smart-splits").move_cursor_left()<cr>' },
        { mode = "n", "<C-j>", '<cmd>lua require("smart-splits").move_cursor_down()<cr>' },
        { mode = "n", "<C-k>", '<cmd>lua require("smart-splits").move_cursor_up()<cr>' },
        { mode = "n", "<C-l>", '<cmd>lua require("smart-splits").move_cursor_right()<cr>' },
        { mode = "n", "<C-w>H", '<cmd>lua require("smart-splits").swap_buf_left({ move_cursor = true })<cr>' },
        { mode = "n", "<C-w>J", '<cmd>lua require("smart-splits").swap_buf_down({ move_cursor = true })<cr>' },
        { mode = "n", "<C-w>K", '<cmd>lua require("smart-splits").swap_buf_up({ move_cursor = true })<cr>' },
        { mode = "n", "<C-w>L", '<cmd>lua require("smart-splits").swap_buf_right({ move_cursor = true })<cr>' },
    },
}
return _M

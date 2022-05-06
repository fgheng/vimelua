require("smart-splits").setup({
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
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-w>r", '<cmd>lua require("smart-splits").start_resize_mode()<cr>', opts)

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<c-left>", require("smart-splits").resize_left)
vim.keymap.set("n", "<c-down>", require("smart-splits").resize_down)
vim.keymap.set("n", "<c-up>", require("smart-splits").resize_up)
vim.keymap.set("n", "<c-right>", require("smart-splits").resize_right)

-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

-- swapping buffers between windows
vim.keymap.set("n", "<C-w>H", '<cmd>lua require("smart-splits").swap_buf_left({ move_cursor = true })<cr>')
vim.keymap.set("n", "<C-w>J", '<cmd>lua require("smart-splits").swap_buf_down({ move_cursor = true })<cr>')
vim.keymap.set("n", "<C-w>K", '<cmd>lua require("smart-splits").swap_buf_up({ move_cursor = true })<cr>')
vim.keymap.set("n", "<C-w>L", '<cmd>lua require("smart-splits").swap_buf_right({ move_cursor = true })<cr>')

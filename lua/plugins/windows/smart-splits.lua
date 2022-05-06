local status_ok, ss = pcall(require, 'smart-splits')
if not status_ok then
    vim.notify('smart-splits not found')
    return
end

ss.setup({
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
        -- 'nofile',
        -- 'quickfix',
        -- 'prompt',
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = {},
    -- when moving cursor between splits left or right,
    -- place the cursor on the same row of the *screen*
    -- regardless of line numbers. False by default.
    -- Can be overridden via function parameter, see Usage.
    move_cursor_same_row = false,
})

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<C-w>r', '<cmd>lua require("smart-splits").start_resize_mode()<cr>', opts)
-- vim.keymap.set('n', '<M-)>', '<cmd>lua require("smart-splits").resize_right(1)<cr>', opts)
-- vim.keymap.set('n', '<M-(>', '<cmd>lua require("smart-splits").resize_left(1)<cr>', opts)
-- vim.keymap.set('n', '<M-->', '<cmd>lua require("smart-splits").resize_down(1)<cr>', opts)
-- vim.keymap.set('n', '<M-_>', '<cmd>lua require("smart-splits").resize_up(1)<cr>', opts)

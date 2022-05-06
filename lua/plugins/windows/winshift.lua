local status_ok, winshift = pcall(require, 'winshift')
if not status_ok then
    vim.notify('winshift not found')
    return
end

winshift.setup({
    highlight_moving_win = true,
    focused_hl_group = "Visual",
    moving_win_options = {
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
    },
    window_picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
    window_picker_ignore = {
        filetype = {
            'NvimTree',
            'Outline'
        },
        buftype = {
            'terminal',
            'quickfix',
            'NvimTree',
            'Outline'
        },
        bufname = {
            [[.*foo/bar/baz\.qux]]
        },
    },
})

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '=', '<cmd>WinShift<cr>', opts)

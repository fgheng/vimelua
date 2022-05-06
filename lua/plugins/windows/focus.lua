local status_ok, focus = pcall(require, 'focus')
if not status_ok then
    vim.notify('focus not found')
    return
end

focus.setup({
    excluded_filetypes = { 'toggleterm', 'NvimTree', 'Outline' },
    compatible_filetrees = { 'filetree', 'nvimtree', 'nerdtree', 'chadtree', 'fern', 'Outline' },
    cursorline = true,
    signcolumn = false,
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<c-w>f', '<cmd>FocusToggle<cr>', opts)
keymap('n', '<c-w>=', '<cmd>FocusEqualise<cr>', opts)
keymap('n', '<c-w>o', '<cmd>FocusMaxOrEqual<cr>', opts)

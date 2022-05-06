local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    vim.notify('toggleterm not found')
    return
end

toggleterm.setup({
      direction = 'float',
})

local opts = { silent = true, noremap = true }
-- vim.keymap.set('t', '<c-h>', [[<c-\><c-n><c-w>h]], opts)
-- vim.keymap.set('t', '<c-j>', [[<c-\><c-n><c-w>j]], opts)
-- vim.keymap.set('t', '<c-k>', [[<c-\><c-n><c-w>k]], opts)
-- vim.keymap.set('t', '<c-l>', [[<c-\><c-n><c-w>l]], opts)
vim.keymap.set('t', '<m-=>', '<cmd>ToggleTerm<cr>', opts)
vim.keymap.set('n', '<m-=>', '<cmd>ToggleTerm<cr>', opts)

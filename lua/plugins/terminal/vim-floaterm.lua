vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

-- 不可以在多个tab下使用floatwindow
local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<m-=>', '<cmd>FloatermToggle<cr>', opts)
vim.keymap.set('n', '<m-->', '<cmd>FloatermKill<cr>', opts)
vim.keymap.set('n', '<m-+>', '<cmd>FloatermNew<cr>', opts)
vim.keymap.set('t', '<m-=>', '<cmd>FloatermToggle<cr>', opts)
vim.keymap.set('t', '<m-->', '<cmd>FloatermKill<cr>', opts)
vim.keymap.set('t', '<m-+>', '<cmd>FloatermNew<cr>', opts)
vim.keymap.set('t', '<m-l>', '<cmd>FloatermNext<cr>', opts)
vim.keymap.set('t', '<m-h>', '<cmd>FloatermPrev<cr>', opts)
vim.keymap.set('n', '<leader>e', function ()
    if vim.fn.executable('ranger') == 1 then
        vim.cmd([[FloatermNew ranger]])
    else
        vim.notify('ranger not found, please install it', vim.log.levels.INFO)
    end
end, opts)


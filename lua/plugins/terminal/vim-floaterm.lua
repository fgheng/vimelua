vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

-- 不可以在多个tab下使用floatwindow
local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<m-=>', '<cmd>FloatermToggle<cr>', opts)
keymap('n', '<m-->', '<cmd>FloatermKill<cr>', opts)
keymap('n', '<m-+>', '<cmd>FloatermNew<cr>', opts)
keymap('t', '<m-=>', '<cmd>FloatermToggle<cr>', opts)
keymap('t', '<m-->', '<cmd>FloatermKill<cr>', opts)
keymap('t', '<m-+>', '<cmd>FloatermNew<cr>', opts)
keymap('t', '<m-l>', '<cmd>FloatermNext<cr>', opts)
keymap('t', '<m-h>', '<cmd>FloatermPrev<cr>', opts)
-- vim.keymap.set('n', '<leader>e', function ()
--     if vim.fn.executable('ranger') == 1 then
--         vim.api.nvim_command([[FloatermNew ranger]])
--     else
--         vim.notify('ranger not found, please install it', vim.log.levels.INFO)
--     end
-- end, opts)
--

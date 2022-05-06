-- local status_ok, ca = pcall(require, '')
-- if not status_ok then
--     vim.notify('vgit not found')
--     return
-- end
local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', 'ca', '<cmd>CodeActionMenu<cr>', opts)

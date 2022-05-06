-- local status_ok, neogen = pcall(require, 'neogen')
-- if not status_ok then
--     vim.notify('neogen not found')
--     return
-- end

require("neogen").setup({
    enabled = true,
    snippet_engine = 'luasnip'
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<leader>dd', '<cmd>lua require("neogen").generate()<cr>', opts)
keymap('n', '<leader>df', '<cmd>lua require("neogen").generate({type = "func"})<cr>', opts)
keymap('n', '<leader>dc', '<cmd>lua require("neogen").generate({type = "class"})<cr>', opts)

local status_ok, neogen = pcall(require, 'neogen')
if not status_ok then
    vim.notify('neogen not found')
    return
end

neogen.setup({
    enabled = true,
    snippet_engine = 'luasnip'
})

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<leader>dd', '<cmd>lua require("neogen").generate()<cr>', opts)
vim.keymap.set('n', '<leader>df', '<cmd>lua require("neogen").generate({type = "func"})<cr>', opts)
vim.keymap.set('n', '<leader>dc', '<cmd>lua require("neogen").generate({type = "class"})<cr>', opts)

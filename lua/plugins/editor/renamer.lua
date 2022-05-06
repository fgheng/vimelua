local status_ok, renamer = pcall(require, 'renamer')

if not status_ok then
    vim.notify('renamer not found')
end

renamer.setup({

})

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', opts)
vim.keymap.set('v', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', opts)

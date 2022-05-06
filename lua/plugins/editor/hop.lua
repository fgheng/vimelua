local status_ok, hop = pcall(require, 'hop')
if not status_ok then
    vim.notify('hop not found')
    return
end

hop.setup({
    keys = 'etovxqpdygfblzhckisuran'
})

local opts = {silent = true, noremap = true}
vim.keymap.set('n', 'f', '<cmd>HopChar1MW<cr>', opts)
vim.keymap.set('n', 'F', '<cmd>HopWordMW<cr>', opts)
vim.keymap.set('n', 'tl', '<cmd>HopLineMW<cr>', opts)

local status_ok, nvim_window = pcall(require, 'nvim-window')
if not status_ok then
    vim.notify('nvim-window not found')
    return
end

nvim_window.setup({
    normal_hl = 'BlackOnLightYellow',
    hint_hl = 'Bold',
    border = 'none'
})

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '-', '<cmd>lua require("nvim-window").pick()<cr>', opts)

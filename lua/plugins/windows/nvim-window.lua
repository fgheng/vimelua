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
local keymap = vim.api.nvim_set_keymap
keymap('n', '<c-w>-', '<cmd>lua require("nvim-window").pick()<cr>', opts)

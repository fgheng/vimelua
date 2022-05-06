local status_ok, neo_zoom = pcall(require, 'neo-zoom')
if not status_ok then
    vim.notify('NeoZoom not found')
    return
end

neo_zoom.setup({
    left_ratio = 0.03,
    top_ratio = 0.03,
    width_ratio = 1,
    height_ratio = 1
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<c-w>o', '<cmd>NeoZoomToggle<cr>', opts)

local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
    vim.notify('bufferline not found')
    return
end

local icons_signs = require('plugins.theme.icons').signs

bufferline.setup({
    options = {
        mode = 'tabs', --'tabs', -- buffers
        -- numbers = 'ordinal',
        numbers = function(opts)
            return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
        close_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        -- indicator_icon = '▎',
        -- buffer_close_icon = '',
        -- modified_icon = '●',
        -- close_icon = '',
        left_trunc_marker = icons_signs.arrow_left,
        right_trunc_marker = icons_signs.arrow_right,
        diagnostics = 'nvim_lsp',

        offsets = {
            { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory', text_align = 'center' },
            { filetype = 'aerial', text = 'Outline', text_align = 'center' },
            { filetype = 'Outline', text = 'Outline', text_align = 'center' },
        },

        color_icons = true,
        show_buffer_icons = true,
        show_buffer_default_icon = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = 'slant' -- | "thick" | "thin" | { 'any', 'any' }, 'slant'
        -- always_show_bufferline = true
    }
})

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<m-h>', '<cmd>BufferLineCyclePrev<cr>', opts)
vim.keymap.set('n', '<m-l>', '<cmd>BufferLineCycleNext<cr>', opts)
vim.keymap.set('n', '<m-q>', '<cmd>BufferLinePickClose<cr>', opts)
vim.keymap.set('n', '<m-b>', '<cmd>BufferLinePick<cr>', opts)

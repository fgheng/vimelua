local status_ok, outline = pcall(require, 'symbols-outline')
if not status_ok then
    vim.notify('symbols-outline not found')
    return
end

outline.setup({
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    -- position = 'right',
    relative_width = false,
    width = 30,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    winblind = 20,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { 'q' },
        goto_location = '<Cr>',
        focus_location = { 'o', 'l' },
        hover_symbol = '<C-space>',
        toggle_preview = 'K',
        rename_symbol = 'R',
        -- code_actions = 'a',
    },
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<F3>', '<cmd>SymbolsOutline<cr>', opts)

-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--     pattern = { 'Outline' },
--     callback = function()
--         vim.opt.signcolumn = 'no'
--     end
-- })

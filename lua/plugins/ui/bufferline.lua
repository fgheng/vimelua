-- local status_ok, bufferline = pcall(require, "bufferline")
local bufferline = require("bufferline")
local icons = require("ui.icons")

bufferline.setup({
    options = {
        mode = "buffers", --'tabs', -- buffers
        numbers = "ordinal",
        -- numbers = function(opts)
        --     return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
        -- end,
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
            icon = icons.line_bold, -- this should be omitted if indicator style is not 'icon'
            style = "icon", -- | "icon" | "underline" | "none",
        },
        buffer_close_icon = icons.close,
        modified_icon = icons.circle,
        close_icon = icons.close,
        left_trunc_marker = icons.arrow_left,
        right_trunc_marker = icons.arrow_right,

        -- diagnostics = "nvim_lsp",
        -- diagnostics_update_in_insert = true,
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --     return "(" .. count .. ")"
        -- end,

        offsets = {
            { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "center" },
            { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "center" },
            { filetype = "aerial", text = "Outline", text_align = "center" },
            { filetype = "Outline", text = "Outline", text_align = "center" },
        },

        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "{'any', 'any'}", -- | "thick" | "thin" | { 'any', 'any' }, 'slant'

        show_duplicate_prefix = false, -- whether to show duplicate buffer prefix
        -- always_show_bufferline = true
        hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
        },
        -- custom_filter = function(buf, buf_nums)
        --     local tab_num = vim.fn.tabpagenr()
        --     local buf_list = vim.fn.tabpagebuflist()
        --     for _, v in ipairs(buf_list) do
        --         if v == buf then
        --             return true
        --         end
        --     end
        --     return false
        -- end,
    },
})

----------------------------------------------------------------------
--                             keymaps                              --
----------------------------------------------------------------------
vim.schedule(function()
    local opts = { silent = true, noremap = true }
    vim.api.nvim_set_keymap("n", "<m-h>", "<cmd>BufferLineCyclePrev<cr>", opts)
    vim.api.nvim_set_keymap("n", "<m-l>", "<cmd>BufferLineCycleNext<cr>", opts)
    vim.api.nvim_set_keymap("n", "<m-q>", "<cmd>BufferLinePickClose<cr>", opts)
    vim.api.nvim_set_keymap("n", "<m-b>", "<cmd>BufferLinePick<cr>", opts)
end)

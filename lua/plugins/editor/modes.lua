require("modes").setup({
    colors = {
        copy = "#f5c359",
        delete = "#c75c6a",
        insert = "#78ccc5",
        visual = "#d765ce",
    },

    -- Set opacity for cursorline and number background
    line_opacity = 0.1,

    -- Enable cursor highlights
    set_cursor = true,

    -- Enable cursorline initially, and disable cursorline for inactive windows
    -- or ignored filetypes
    set_cursorline = true,

    -- Enable line number highlights to match cursorline
    set_number = true,

    -- Disable modes highlights in specified filetypes
    -- Please PR commonly ignored filetypes
    ignore_filetypes = { 'TelescopePrompt', 'NvimTree', 'neo-tree' }
})

-- vim.defer_fn(function()
--     vim.api.nvim_set_hl(0, "CursorLine", { bg = "#dfc3e1" })
-- end, 10)

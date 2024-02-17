local _M = {
    "mvllow/modes.nvim",
    enabled = false,
    tag = "v0.2.0",
    event = { "ModeChanged", "InsertEnter", "CursorMoved" },
    opts = {
        colors = {
            copy = "#f5c359",
            delete = "#c75c6a",
            insert = "#38ccc5",
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
        ignore_filetypes = { "TelescopePrompt", "NvimTree", "neo-tree" },
    },
}
_M = {}
return _M

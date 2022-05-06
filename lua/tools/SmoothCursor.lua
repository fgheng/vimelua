local _M = {
    "gen740/SmoothCursor.nvim",
    enabled = true,
    event = { "CursorMoved" },
    opts = {
        cursor = require("utils.icons").symbols.select_arrow, -- cursor shape (need nerd font)
        texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
        linehl = "cursorLine", -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
        type = "exp", -- define cursor movement calculate function, "default" or "exp" (exponential).
        fancy = {
            enable = false, -- enable fancy mode
            head = { cursor = require("utils.icons").symbols.select_arrow, texthl = "SmoothCursor", linehl = nil },
            body = {
                { cursor = "󰝥", texthl = "SmoothCursorRed" },
                { cursor = "󰝥", texthl = "SmoothCursorOrange" },
                { cursor = "●", texthl = "SmoothCursorYellow" },
                { cursor = "●", texthl = "SmoothCursorGreen" },
                { cursor = "•", texthl = "SmoothCursorAqua" },
                { cursor = ".", texthl = "SmoothCursorBlue" },
                { cursor = ".", texthl = "SmoothCursorPurple" },
            },
            tail = { cursor = nil, texthl = "SmoothCursor" },
        },
        flyin_effect = "top", -- "bottom" or "top"
        speed = 80, -- max is 100 to stick to your current position
        intervals = 35, -- tick interval
        priority = 1, -- set marker priority
        timeout = 3000, -- timeout for animation
        threshold = 3, -- animate if threshold lines jump
        disable_float_win = true, -- disable on float window
        enabled_filetypes = nil, -- example: { "lua", "vim" }
        disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "Teles
    },
}
return _M

local _M = {
    "karb94/neoscroll.nvim",
    enabled = true,
    config = function()
        require("neoscroll").setup({
            mappings = { -- Keys to be mapped to their corresponding default scrolling animation
                "<C-u>",
                "<C-d>",
                "<C-b>",
                "<C-f>",
                "<C-y>",
                "<C-e>",
                "zt",
                "zz",
                "zb",
            },
            hide_cursor = true, -- Hide cursor while scrolling
            stop_eof = true, -- Stop at <EOF> when scrolling downwards
            respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing = "linear", -- Default easing function
            performance_mode = false, -- Disable "Performance Mode" on all buffers.
            pre_hook = function()
                vim.opt.eventignore:append({
                    "WinScrolled",
                    "CursorMoved",
                })
            end,
            post_hook = function()
                vim.opt.eventignore:remove({
                    "WinScrolled",
                    "CursorMoved",
                })
            end,
        })
    end,
    keys = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
    },
}
return _M

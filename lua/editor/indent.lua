local highlight = {
    -- "CursorColumn",
    -- "Whitespace",
}

local _M = {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    main = "ibl",
    cmd = {
        "IndentBlanklineToggle",
        "IndentBlanklineEnable",
        "IndentBlanklineRefresh",
    },
    opts = {
        indent = { highlight = highlight, char = "" },
        whitespace = { highlight = highlight, remove_blankline_trail = false },
        scope = { highlight = highlight, enabled = true },
    },
}
return _M

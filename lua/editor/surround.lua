local _M = {
    "ur4ltz/surround.nvim",
    enabled = true,
    opts = {
        mappings_style = "surround",
        space_on_closing_char = false,
    },
    keys = {
        { mode = "n", "cs" },
        { mode = "n", "ds" },
        { mode = "n", "ys" },
    },
}

return _M

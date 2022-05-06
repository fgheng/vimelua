local _M = {
    "phaazon/hop.nvim",
    enabled = true,
    branch = "v2",
    opts = {
        keys = "etovxqpdygfblzhckisuran",
    },
    -- keys = { "f", "F", "W" },
    keys = {
        { mode = "n", "W", "<cmd>HopWordMW<cr>", "Hop word" },
        {
            mode = "n",
            "f",
            function()
                require("hop").hint_char1({ --[[ direction = directions.AFTER_CURSOR,]]
                    current_line_only = true,
                })
            end,
            "Hop char",
        },
        { mode = "n", "F", "<cmd>HopChar1MW<cr>", "Hop char" },
    },
}
return _M

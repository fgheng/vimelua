--     Old text                    Command         New text
-- --------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
local _M = {

    {
        "echasnovski/mini.surround",
        enabled = false,
        config = function()
            require("mini.surround").setup()
        end,
        keys = {
            { mode = "n", "sa" },
            { mode = "n", "sd" },
            { mode = "n", "sr" },
        }
    },
    {
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
    },
}

return _M

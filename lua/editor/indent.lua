local _M = {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    main = "ibl",
    cmd = {
        "IBLEnable",
        "IBLToggle",
        -- "IBLEnableScope",
        -- "IBLToggleScope",
    },

    config = function()
        require("ibl").setup({
            indent = {
                char = "▏",
                tab_char = { "▏" },
                highlight = { "DiagnosticHint" },
                smart_indent_cap = true,
                priority = 2,
                repeat_linebreak = false,
            },
            exclude = {
                filetypes = { "markdown" },
                buftypes = { "terminal", "nofile", "quickfix", "help", "prompt" },
            },
        })
    end,
}
return _M

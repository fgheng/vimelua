local _M = {
    {
        "akinsho/toggleterm.nvim",
        cmd = { "TermExec", "TermSelect" },
        opts = {
                direction = "horizontal", -- | 'tab' | 'float' | 'vertical' |
                hide_numbers = true,
                winbar = {
                    enabled = false,
                    name_formatter = function(term) --  term: Terminal
                        return term.name
                    end,
                },
                open_mapping = [[<m-=>]],
                autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
                start_in_insert = false,
                close_on_exit = true, -- close the terminal window when the process exits
        },
        keys = {
            { mode = "t", "<m-=>" },
            { mode = "n", "<m-=>" },
            { mode = "n", "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select terminal" },
            { mode = "n", "<m-=>", "<cmd>ToggleTermSendVisualLines<cr>", desc = "Select terminal" },
        },
    },
    {
        "chomosuke/term-edit.nvim",
        lazy = true,
        ft = { "toggleterm", "floaterm" },
        version = "1.*",
        opts = {
            prompt_end = "%$ ",
        },
    },
}
return _M

require("copilot").setup({
    panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
            jump_prev = "<M-k>",
            jump_next = "<M-j>",
            accept = "<CR>",
            refresh = "<M-r>",
            open = "<M-CR>",
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-j>",
            prev = "<M-k>",
            dismiss = "<M-h>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["dap-repl"] = false,
        ["."] = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 16.x
    server_opts_overrides = {},
})

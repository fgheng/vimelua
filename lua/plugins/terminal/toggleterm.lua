require("toggleterm").setup({
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
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

-- keymap("t", "<m-=>", "<cmd>ToggleTerm<cr>", opts)
-- keymap("n", "<m-=>", "<cmd>ToggleTerm<cr>", opts)
keymap("n", "<leader>ts", "<cmd>TermSelect<cr>", opts)
keymap("v", "<m-=>", "<cmd>ToggleTermSendVisualLines<cr>", opts)
-- keymap("n", "<leader>tt", "<cmd>ToggleTerm direction='tab'<cr>", opts)

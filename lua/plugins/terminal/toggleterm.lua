require("toggleterm").setup({
    -- direction = 'float',
    hide_numbers = true,
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end,
    },
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("t", "<m-=>", "<cmd>ToggleTerm<cr>", opts)
keymap("n", "<m-=>", "<cmd>ToggleTerm<cr>", opts)
-- keymap("v", "<leader>t", "<cmd>ToggleTermSendVisualSelection<cr>", opts)

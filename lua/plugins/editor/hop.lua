local hop = require("hop")

hop.setup({
    keys = "etovxqpdygfblzhckisuran",
})

-- ----------------------------------------------------------------------
-- --                            highlight                             --
-- ----------------------------------------------------------------------
-- vim.api.nvim_command([[hi link HopNextKey WarningMsg]])
-- vim.api.nvim_command([[hi link HopNextKey WarningMsg]])
-- vim.api.nvim_command([[hi link HopNextKey WarningMsg]])

----------------------------------------------------------------------
--                             keymaps                              --
----------------------------------------------------------------------
local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
-- keymap("n", "f", "<cmd>HopChar1MW<cr>", opts)
-- keymap("n", "w", "<cmd>HopWordCurrentLine<cr>", opts)
keymap("n", "W", "<cmd>HopWordMW<cr>", opts)
-- keymap("n", "w", "<cmd>HopWordMW<cr>", opts)
-- keymap("n", "tl", "<cmd>HopLineMW<cr>", opts)
-- local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
    hop.hint_char1({ --[[ direction = directions.AFTER_CURSOR,]]
        current_line_only = true,
    })
end, { remap = true })
-- vim.keymap.set("", "F", function()
--     hop.hint_char1({ --[[ direction = directions.BEFORE_CURSOR,]]
--         current_line_only = false,
--     })
-- end, { remap = true })
keymap("n", "F", "<cmd>HopChar1MW<CR>", opts)

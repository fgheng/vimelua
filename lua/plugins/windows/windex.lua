local windex = require('windex')

windex.setup({
    default_keymaps = false,
    extra_keymaps = false,
    arrow_keys = false,
    disable = false,
    numbered_term = false,
    save_buffers = true, -- Save all buffers before switching tmux panes.
    warnings = true,
})


local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<c-w>o', '<cmd>lua require("windex").toggle_nvim_maximize()<cr>', opts)
-- using tmux maxsize instead
-- keymap('n', '<c-w>O', '<cmd>lua require("windex").toggle_maximize()<cr>', opts)
-- vim.keymap.set('n', '<c-w>o', function ()
--     require('shade').toggle()
--     require('windex').toggle_nvim_maximize()
--     require('shade').toggle()
-- end, opts)

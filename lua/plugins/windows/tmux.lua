-- local status_ok, tmux = pcall(require, 'tmux')
-- if not status_ok then
--     vim.notify('tmux not found')
--     return
-- end

require("tmux").setup({
    copy_sync = {
        enable = true,
    },
    navigation = {
        cycle_navigation = false,
        enable_default_keybindings = true,
        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
    },
    resize = {
        enable = false,
        -- default keys is (A-hkjl)
        enable_default_keybindings = false,
        -- sets resize steps for x axis
        resize_step_x = 1,
        -- sets resize steps for y axis
        resize_step_y = 1,
    },
})

-- local opts = { silent = true, noremap = true }
-- local keymap = vim.api.nvim_set_keymap
-- keymap('n', '<m-H>', '<cmd>lua require("tmux").resize_left()<cr>', opts)
-- keymap('n', '<m-L>', '<cmd>lua require("tmux").resize_right()<cr>', opts)
-- keymap('n', '<m-K>', '<cmd>lua require("tmux").resize_top()<cr>', opts)
-- keymap('n', '<m-J>', '<cmd>lua require("tmux").resize_bottom()<cr>', opts)

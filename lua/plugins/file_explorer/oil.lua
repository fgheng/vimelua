-- local status_ok, oil = pcall(require, "oil")
-- if not status_ok then
--     vim.notify("oil not found")
--     return
-- end

require("oil").setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    -- Window-local options to use for oil buffers
    win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
    },
    -- Restore window options to previous values when leaving an oil buffer
    restore_win_options = true,
    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = false,
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
    -- Additionally, if it is a string that matches "action.<name>",
    -- it will use the mapping at require("oil.action").<name>
    -- Set to `false` to remove a keymap
    keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["l"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["K"] = "actions.preview",
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
        ["r"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
        ["h"] = "actions.parent",
        -- ["_"] = "actions.open_cwd",
        ["~"] = "actions.open_cwd",
        -- ["`"] = "actions.cd",
        ["cd"] = "actions.tcd",
        -- ["g."] = "actions.toggle_hidden",
        ["."] = "actions.toggle_hidden",
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 50,
        max_height = 50,
        border = "rounded",
        win_options = {
            winblend = 10,
        },
        relative = "cursor",
    },
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>o", "<cmd>Oil<cr>", opts)

local path = require("plenary.path")

require("session_manager").setup({
    sessions_dir = path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
    path_replacer = "__", -- The character to which the path separator will be replaced for session files.
    colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
    autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = false, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        "gitcommit",
    },
    autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 80,
})

----------------------------------------------------------------------
--                             autocmd                              --
----------------------------------------------------------------------
local config_group = vim.api.nvim_create_augroup("vimeGroup_neo_tree", {})

vim.api.nvim_create_autocmd({ "SessionLoadPost" }, {
    group = config_group,
    callback = function()
        vim.api.nvim_command("Neotree")
    end,
})

----------------------------------------------------------------------
--                              keymap                              --
----------------------------------------------------------------------
local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>sl", "<cmd>SessionManager load_session<cr>", opts)

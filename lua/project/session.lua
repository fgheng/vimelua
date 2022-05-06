local _M = {
    "Shatur/neovim-session-manager",
    enabled = false,
    event = "BufWritePost",
    cmd = "SessionManager",
    config = function()
        local path = require("plenary.path")
        local config = require("session_manager.config")
        require("session_manager").setup({
            sessions_dir = path:new(vim.fn.stdpath("data"), "sessions"),
            autoload_mode = config.AutoloadMode.LastSession,
            autosave_last_session = true,
            autosave_ignore_not_normal = true,
            autosave_ignore_dirs = {},
            autosave_ignore_filetypes = {
                "gitcommit",
                "gitrebase",
            },
            autosave_ignore_buftypes = {},
            autosave_only_in_session = false,
            max_path_length = 80,
        })

        local config_group = vim.api.nvim_create_augroup("vime_session", {})

        vim.api.nvim_create_autocmd({ "SessionLoadPost" }, {
            group = config_group,
            callback = function()
                -- local cwd = vim.uv.cwd()
                vim.api.nvim_command("NeoTreeClose")
                vim.api.nvim_command("NeoTreeShow")
            end,
        })
    end,
    keys = {
        {
            "<leader>sl",
            function()
                pcall(require, "telescope")
                vim.api.nvim_command("SessionManager load_session")
            end,
            desc = "Load sessions",
        },
        {
            "<leader>sd",
            function()
                pcall(require, "telescope")
                vim.api.nvim_command("SessionManager delete_session")
            end,
            desc = "Load sessions",
        },
        {
            "<leader>ss",
            function()
                pcall(require, "telescope")
                vim.api.nvim_command("SessionManager available_commands")
            end,
            desc = "Load sessions",
        },
    },
}

return _M

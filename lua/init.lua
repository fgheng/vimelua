local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "lsp" },
        { import = "ai" },
        { import = "completion" },
        { import = "project" },
        { import = "debug" },
        { import = "editor" },
        { import = "git" },
        { import = "ui" },
        { import = "notes" },
        { import = "tools" },
    },

    root = vim.fn.stdpath("data") .. "/lazy",
    defaults = {
        lazy = true, -- should plugins be lazy-loaded?
    },
    lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
    git = {
        -- defaults for the `Lazy log` command
        -- log = { "-10" }, -- show the last 10 commits
        log = { "--since=3 days ago" }, -- show commits from the last 3 days
        timeout = 120, -- kill processes that take more than 2 minutes
        url_format = "https://github.com/%s.git",
    },
    dev = {
        -- directory where you store your local plugin projects
        path = "~/workspace/neovim-dev",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example {"folke"}
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "habamax" },
    },
    ui = {
        border = require("config").ui.float_ui_win.border,
        size = {
            width = require("config").ui.float_ui_win.width,
            height = require("config").ui.float_ui_win.height,
        },
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = false,
        notify = false, -- get a notification when changes are found
    },
    performance = {
        cache = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/lazy/cache",
            -- Once one of the following events triggers, caching will be disabled.
            -- To cache all modules, set this to `{}`, but that is not recommended.
            -- The default is to disable on:
            --  * VimEnter: not useful to cache anything else beyond startup
            --  * BufReadPre: this will be triggered early when opening a file from the command line directly
            disable_events = {},
            ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to indluce in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "netrw",
                "netrwSettings",
                "netrwFileHandlers",
                "gzip",
                "zip",
                "tar",
                "getscript",
                "getscriptPlugin",
                "vimball",
                "vimballPlugin",
                "2html_plugin",
                "logipat",
                "rrhelper",
                "spellfile_plugin",
                "man",
                "tutor_mode_plugin",
                "remote_plugins",
                "shada_plugin",
                "filetype",
                "syntax",
                "ftplugin",
                "ftindent",
                "spellfile",
                "editorconfig",
                "fzf",
                "skim",
                "osc52",
                "shada",
                "rplugin",
            },
        },
    },
    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    -- readme = {
    --     root = vim.fn.stdpath("state") .. "/lazy/readme",
    --     files = { "README.md" },
    --     -- only generate markdown helptags for plugins that dont have docs
    --     skip_if_doc_exists = true,
    -- },
})

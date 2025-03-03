local _M = {}

_M.picker = "fzf-lua"

_M.ui = {
    theme = {
        theme = "everforest",
        background = "dark",
        transparent = 0.8,
    },
    float_ui_win = {
        -- Can be one of the pre-defined styles: `"double"`, `"none"`, `"rounded"`, `"shadow"`, `"single"` or `"solid"`.
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        border = "double",
        width = 0.8,
        height = 0.8,
    },

    sidebar_width = 40
}

-- _M.node_path = ""
-- _M.python_path = ""

_M.notes_home = vim.fn.expand("~/notes")
_M.snippet_path = vim.fn.stdpath("config") .. "/snippets/"

_M.treesitter = {
    languages = {
        "cpp",
        "c",
        "bash",
        "lua",
        "rust",
        "java",
        "python",
        "json",
        "go",
        "yaml",
        "html",
        "vim",
        "markdown",
        "markdown_inline",
        "regex",
        "norg",
        "latex",
    },
    disanble_languages = {
        "txt",
        "help",
    },
}

_M.servers = {
    lsp_servers = {
        "clangd",
        "pyright",
        "lua_ls",
        "rust_analyzer",
        "bashls",
        "jdtls",
        "gopls",
        "buf_ls",
        "zk",
        "denols",
        "jsonls"
        -- "basics_ls" -- npm install -g basics-language-server
    },
    linter = {
        -- "write_good",
        -- "cppcheck",
        -- "shellcheck",
    },
    formatter = {
        -- "prettierd",
        -- "stylua",
        -- "black",
        -- "cmake_format",
        -- "google_java_format",
        -- "shfmt",
        -- "rustfmt",
        -- "clang_format",
    },
    dap = {},
}

return _M

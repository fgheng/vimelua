local _M = {}

_M.node_path = ""
_M.python_path = ""

_M.snippet_path_vscode = vim.fn.stdpath("config") .. "/snippets/vscode/"

_M.notes_home = os.getenv("ZK_NOTEBOOK_DIR")

_M.theme = {
    background = "dark",
    theme = "vscode",
}

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
        "bufls",
        "zk",
    },
    linter = {
        "write_good",
        "cppcheck",
        "shellcheck",
    },
    formatter = {
        "prettierd",
        "stylua",
        "autopep8",
        "cmake_format",
        "google_java_format",
        "beautysh",
        "rustfmt",
        "clang_format"
    },
    dap = {},
}

return _M

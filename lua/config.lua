local _M = {}

----------------------------------------------------------------------
--                           path config                            --
----------------------------------------------------------------------
_M.node_path = ""
_M.python_path = ""

_M.snippet_path_vscode = vim.fn.stdpath("config") .. "/snippets/vscode/"

----------------------------------------------------------------------
--                               wiki                               --
----------------------------------------------------------------------
_M.wiki_home = "~/notes"

----------------------------------------------------------------------
--                           theme config                           --
----------------------------------------------------------------------
_M.colorscheme = {
    background = "dark",
    background_color = "#ffffff",
    theme_group = "everforest",
    theme = "everforest",
}

----------------------------------------------------------------------
--                        treesitter config                         --
----------------------------------------------------------------------
_M.treesitter_languages = {
    -- "cpp",
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
    -- "norg",
    -- "org"
}

_M.treesitter_disable_languages = {
    "txt",
    "help",
}

----------------------------------------------------------------------
--                            lsp config                            --
----------------------------------------------------------------------
_M.lsp_servers = {
    "clangd",
    "pyright",
    "lua_ls",
    "rust_analyzer",
    "bashls",
    "jdtls",
    "gopls",
}

----------------------------------------------------------------------
--                          debugger config                          --
----------------------------------------------------------------------
local status_ok, _ = pcall(require, "dap")
if not status_ok then
    return _M
end

local get_args = function()
    local input = vim.fn.input("dap-args: ")
    return require("utils").str2argtable(input)
end

local debug_server_config = {
    python = {
        adapter = {
            type = "executable", -- or server, which needs host and port
            command = "python",
            args = { "-m", "debugpy.adapter" },
        },
        config = {
            {
                name = "Launch file",
                type = "python",
                request = "launch",
                program = "${file}",
                args = get_args,
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                        return cwd .. "/venv/bin/python"
                    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                        return cwd .. "/.venv/bin/python"
                    else
                        return "python"
                    end
                end,
            },
        },
    },

    cpp = {
        adapter = {
            id = "cppdbg",
            type = "executable",
            command = "/home/forever/Software/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
        },
        config = {
            {
                name = "Launch File",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                args = get_args,
                cwd = "${workspaceFolder}",
                stopOnEntry = true,
            },
            {
                name = "Attach to gdbserver :1234",
                type = "cppdbg",
                request = "launch",
                MIMode = "gdb",
                miDebuggerServerAddress = "localhost:1234",
                miDebuggerPath = "/usr/bin/gdb",
                cwd = "${workspaceFolder}",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
            },
            {
                name = "Attach process",
                type = "cppdbg",
                request = "attach",
                processId = require("dap.utils").pick_process,
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                setupCommands = {
                    {
                        description = "enable pretty printing",
                        text = "-enable-pretty-printing",
                        ignoreFailures = false,
                    },
                },
            },
        },
    },
}

_M.debug_servers = {
    names = {
        python = "python",
        cpp = "cppdbg",
        c = "c",
        rust = "rust",
    },
    config = {
        python = debug_server_config.python,
        cpp = debug_server_config.cpp,
        c = debug_server_config.cpp,
        rust = debug_server_config.cpp,
    },
}

return _M

local _M = {}

_M.colorscheme = {
    light = false,
    theme = 'dawnfox'
}

_M.node_path = ''
_M.python_path = ''

_M.snippet_path = vim.fn.stdpath('config') .. '/snippets/vscode/'

----------------------------------------------------------------------
--                        treesitter config                         --
----------------------------------------------------------------------
_M.treesitter_languages = {
    'cpp',
    'c',
    'bash',
    'lua',
    'rust',
    'java',
    'python',
    'json',
    'go',
    'yaml',
    'html'
}

----------------------------------------------------------------------
--                            lsp config                            --
----------------------------------------------------------------------
local lsp_server_config = {
    clangd = {
        offset_encodings = 'utf-16',
        cmd = {
            'clangd',
            '--background-index', -- 后台建立索引，并持久化到disk
            '--completion-style=detailed',
            -- '--cross-file-rename=true',
            '--header-insertion=iwyu',
            '--pch-storage=memory',
            -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
            '--function-arg-placeholders=false',
            '--log=verbose',
            '--ranking-model=decision_forest',
            -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
            '--header-insertion-decorators',
            '-j=12',
            '--pretty',
        },
    },

    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.stdpath('config') .. '/lua'] = true,
                    },
                },
            },
        },
    },

    pyright = {
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = 'off'
                }
            }
        },
    }
}

_M.lsp_servers = {
    names = {
        'clangd',
        'pyright',
        'sumneko_lua',
        'rust_analyzer',
        'bashls',
        'jdtls'
    },

    config = {
        clangd = lsp_server_config.clangd,
        pyright = lsp_server_config.pyright,
        sumneko_lua = lsp_server_config.sumneko_lua
    }
}

----------------------------------------------------------------------
--                          debuger config                          --
----------------------------------------------------------------------
local status_ok, _ = pcall(require, 'dap')
if not status_ok then
    return _M
end

local get_args = function()
    local input = vim.fn.input('dap-args: ')
    return require('utils').str2argtable(input)
end

local debug_server_config = {
    python = {
        adapter = {
            type = 'executable', -- or server, which needs host and port
            command = 'python',
            args = { '-m', 'debugpy.adapter' }
        },
        config = {
            {
                name = 'Launch file';
                type = 'python';
                request = 'launch';
                program = '${file}';
                args = get_args;
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return 'python'
                    end
                end;
            }

        },
    },

    cpp = {
        adapter = {
            id = 'cppdbg',
            type = 'executable',
            command = '/home/forever/Software/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
        },
        config = {
            {
                name = 'Launch File',
                type = 'cppdbg',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                args = get_args,
                cwd = '${workspaceFolder}',
                stopOnEntry = true,
            },
            {
                name = 'Attach to gdbserver :1234',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:1234',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
            },
            {
                name = 'Attach process',
                type = 'cppdbg',
                request = 'attach',
                processId = require('dap.utils').pick_process,
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                setupCommands = {
                    {
                        description = 'enable pretty printing',
                        text = '-enable-pretty-printing',
                        ignoreFailures = false
                    },
                },
            }
        },
    },
}

_M.debug_servers = {
    names = {
        python = 'python',
        cpp = 'cppdbg',
        c = 'c',
        rust = 'rust',
    },
    config = {
        python = debug_server_config.python,
        cpp = debug_server_config.cpp,
        c = debug_server_config.cpp,
        rust = debug_server_config.cpp
    }
}

return _M

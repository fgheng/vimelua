return {
    settings = {
        Lua = {
            format = {
                enable = false,
            },
            diagnostics = {
                globals = { "vim", "spec" },
            },
            runtime = {
                version = "LuaJIT",
                special = {
                    spec = "require",
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
            hint = {
                enable = true,
                -- arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
                -- await = true,
                -- paramName = "Literal", -- "All" | "Literal" | "Disable"
                -- paramType = true,
                -- semicolon = "All", -- "All" | "SameLine" | "Disable"
                -- setType = false,
            },
            telemetry = {
                enable = false,
            },
            -- Do not override treesitter lua highlighting with lua_ls's highlighting
            semantic = {
                enable = false,
            },
        },
    },
    filetypes = { "lua" },
}

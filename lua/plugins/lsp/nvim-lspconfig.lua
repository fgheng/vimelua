----------------------------------------------------------------------
--                      mason-lspconfig config                      --
----------------------------------------------------------------------
-- local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
-- if not mason_lspconfig_ok then
--     vim.notify("mason-lspconfig not found")
--     return
-- end
local mason_lspconfig = require("mason-lspconfig")

local server_names = require("config").lsp_servers
mason_lspconfig.setup({
    ensure_installed = server_names,
})

-- ----------------------------------------------------------------------
-- --              some plugins that depends on lspconfig              --
-- ----------------------------------------------------------------------
-- local navic_ok, navic = pcall(require, 'nvim-navic')

----------------------------------------------------------------------
--                         nvim-lsp config                          --
----------------------------------------------------------------------
-- local lsp_config_ok, lspconfig = pcall(require, "lspconfig")
-- if not lsp_config_ok then
--     vim.notify("lspconfig not found")
--     return
-- end
local lspconfig = require("lspconfig")

-- local capabilities = vim.lsp.protocol.make_client_capabilities()

mason_lspconfig.setup_handlers({
    function(server_name) -- default handler (optional)
        if server_name ~= "jdtls" then
            lspconfig[server_name].setup({
                -- on_init = function(client) end,
                -- on_attach = function(client, bufnr) end,
            })
        end
    end,
    ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup({})
    end,
    ["lua_ls"] = function()
        lspconfig.sumneko_lua.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
    end,
    ["clangd"] = function()
        lspconfig.clangd.setup({
            -- capabilities = capabilities,
            cmd = {
                "clangd",
                "--offset-encoding=utf-16",
                -- "--malloc-trim=true",
                "--background-index=true", -- 后台建立索引，并持久化到disk
                -- "--completion-style=detailed",
                -- '--cross-file-rename=true',
                "--header-insertion=iwyu",
                "--pch-storage=memory",
                -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
                "--function-arg-placeholders=false",
                -- "--log=verbose",
                "--ranking-model=decision_forest",
                -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
                "--header-insertion-decorators",
                "--pch-storage=memory",
                "-j=12",
                -- "--pretty",
            },
        })
    end,
    ["pyright"] = function()
        lspconfig.pyright.setup({
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "off",
                    },
                },
            },
        })
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup({
            settings = {
                json = {
                    format = {
                        enable = true,
                    },
                    validate = {
                        enable = true,
                    },
                },
            },
        })
    end,
    -- ["bashls"] = function()
    -- 	lspconfig.bashls.setup({})
    -- end,
    -- ['jdtls'] = function()
    --     lspconfig.jdtls.setup({
    --         cmd = {
    --             'jdtls',
    --             '-data',
    --             vim.fn.getcwd() .. '/../java-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    --         },
    --         root_dir = lspconfig.util.root_pattern('.git', 'pom.xml', 'build.xml', 'settings.gradle',
    --             'settings.gradle.kts', vim.fn.getcwd()),
    --         single_file_support = true
    --     })
    -- end
})

vim.defer_fn(function()
    ----------------------------------------------------------------------
    --                             key map                              --
    ----------------------------------------------------------------------
    local opts = { silent = true, noremap = true }
    local keymap = vim.api.nvim_set_keymap

    keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
    keymap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
    keymap("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
    -- keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    -- keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    -- keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap("n", "?", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    -- keymap("n", "<m-j>", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>", opts)
    -- keymap("n", "<m-k>", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>", opts)
    keymap("n", "<m-j>", "<cmd>lua vim.diagnostic.goto_next({float = true})<cr>", opts)
    keymap("n", "<m-k>", "<cmd>lua vim.diagnostic.goto_prev({float = true})<cr>", opts)
    -- keymap('n', '?', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    -- keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = false})<cr>", opts)
    -- keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
    -- vim.api.nvim_create_user_command("format", vim.lsp.buf.format, {async = false})
end, 100)

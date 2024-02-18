local _M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local keymaps = function(_, bufnr)
            local opts = { silent = true, noremap = true, buffer = bufnr }
            local keymap = vim.keymap.set

            if vim.bo.filetype == "java" then
                keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            else
                keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
            end
            keymap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
            -- keymap("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
            keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>", opts)
            keymap("n", "go", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>", opts)
            -- keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            -- keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            -- keymap("n", "gi", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", opts)
            -- keymap("n", "go", "<cmd>lua vim.lsp.buf.outgoint_calls()<cr>", opts)
            keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            vim.keymap.set("n", "K", function()
                if vim.bo.filetype == "help" then
                    vim.api.nvim_feedkeys("<c-]>", "n", true)
                else
                    vim.lsp.buf.hover()
                end
            end, opts)
            keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            keymap("n", "?", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
            keymap("n", "<m-j>", "<cmd>lua vim.diagnostic.goto_next({float = true})<cr>", opts)
            keymap("n", "<m-k>", "<cmd>lua vim.diagnostic.goto_prev({float = true})<cr>", opts)
            keymap("n", "<leader>f", function()
                local ft = vim.bo[bufnr].filetype
                local have_nls = package.loaded["null-ls"]
                    and #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

                vim.lsp.buf.format({
                    filter = function(client)
                        if have_nls then
                            -- apply whatever logic you want (in this example, we'll only use null-ls)
                            return client.name == "null-ls"
                        end
                        return client.name ~= "null-ls"
                    end,
                })
            end, opts)
            keymap("v", "<leader>f", function()
                local ft = vim.bo[bufnr].filetype
                local have_nls = package.loaded["null-ls"]
                    and #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

                vim.lsp.buf.format({
                    filter = function(client)
                        if have_nls then
                            -- apply whatever logic you want (in this example, we'll only use null-ls)
                            return client.name == "null-ls"
                        end
                        return client.name ~= "null-ls"
                    end,
                })
            end, opts)
        end

        local func_lsp_highlight = function(client, bufnr)
            if client.supports_method("textDocument/documentHighlight") then
                vim.api.nvim_create_augroup("lsp_document_highlight", {
                    clear = false,
                })
                vim.api.nvim_clear_autocmds({
                    buffer = bufnr,
                    group = "lsp_document_highlight",
                })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    group = "lsp_document_highlight",
                    buffer = bufnr,
                    callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    group = "lsp_document_highlight",
                    buffer = bufnr,
                    callback = vim.lsp.buf.clear_references,
                })
            end
        end

        vim.lsp.set_log_level("off")

        local lspconfig = require("lspconfig")
        local servers = require("config").servers.lsp_servers

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = true,
            lineFoldingOnly = true,
        }
        capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits" },
            },
        }

        for _, lsp in pairs(servers) do
            local opts = {
                on_attach = function(client, bufnr)
                    vim.schedule(function()
                        keymaps(client, bufnr)
                        func_lsp_highlight(client, bufnr)
                        vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled())
                    end)
                end,
                capabilities = capabilities,
                handlers = {
                    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                        border = "rounded",
                        silent = true,
                        -- focusable = false,
                    }),
                    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                        border = "rounded",
                        silent = true,
                        -- focusable = false,
                    }),
                },
            }

            local status_ok, server_config = pcall(require, "lsp.languages." .. lsp)
            if status_ok then
                opts = vim.tbl_deep_extend("force", opts, server_config)
                lspconfig[lsp].setup(opts)
            end
        end
    end,
}

return _M

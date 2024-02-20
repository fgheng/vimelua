local _M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local keymaps = function(_, bufnr)
            local opts = { silent = true, noremap = true, buffer = bufnr }
            local keymap = vim.keymap.set

            keymap("n", "gd", function()
                require("telescope.builtin").lsp_definitions()
                -- vim.lsp.buf.definition()
            end, opts)
            keymap("n", "gr", function()
                require("telescope.builtin").lsp_references()
                -- vim.lsp.buf.references()
            end, opts)
            -- keymap("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
            keymap("n", "gi", function()
                require("telescope.builtin").lsp_incoming_calls()
                -- vim.lsp.buf.incoming_calls()
            end, opts)
            keymap("n", "go", function()
                require("telescope.builtin").lsp_outgoing_calls()
                -- vim.lsp.buf.outgoing_calls()
            end, opts)
            keymap("n", "gD", function()
                vim.lsp.buf.declaration()
            end, opts)
            keymap("n", "ca", function()
                vim.lsp.buf.code_action()
            end, opts)
            vim.keymap.set("n", "K", function()
                if vim.bo.filetype == "help" then
                    vim.api.nvim_feedkeys("<c-]>", "n", true)
                else
                    vim.lsp.buf.hover()
                end
            end, opts)
            keymap("n", "<leader>rn", function()
                vim.lsp.buf.rename()
            end, opts)
            keymap("n", "?", function()
                vim.diagnostic.open_float()
            end, opts)
            keymap("n", "<m-j>", function()
                vim.diagnostic.goto_next({ float = true })
            end, opts)
            keymap("n", "<m-k>", function()
                vim.diagnostic.goto_prev({ float = true })
            end, opts)
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
            keymap("n", "<space>o", function ()
                require("telescope.builtin").lsp_document_symbols()
                -- vim.lsp.buf.document_symbol()
            end, opts)
            keymap("n", "<space>O", function ()
                require("telescope.builtin").lsp_dynamic_workspace_symbols()
                -- vim.lsp.buf.workspace_symbol()
            end, opts)
            keymap("v", "<space>o", function()
                local selected_text = require("utils.utils").get_visual_selection()
                selected_text = string.gsub(selected_text, "\n", "")
                require("telescope.builtin").lsp_document_symbols({ default_text = selected_text })
            end, opts)
            keymap("v", "<space>O", function()
                local selected_text = require("utils.utils").get_visual_selection()
                selected_text = string.gsub(selected_text, "\n", "")
                require("telescope.builtin").lsp_dynamic_workspace_symbols({ default_text = selected_text })
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

        vim.lsp.set_log_level("ERROR")

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

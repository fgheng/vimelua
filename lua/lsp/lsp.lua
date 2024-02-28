local _M = {
    {
        "neovim/nvim-lspconfig",
        enabled = true,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local keymaps = function(client, bufnr)
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
                    local cbuf = vim.api.nvim_get_current_buf()
                    local ft = vim.api.nvim_get_option_value("filetype", {
                        buf = cbuf,
                    })
                    local have_nls = package.loaded["null-ls"]
                        and #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

                    -- vim.lsp.buf.format({ async = false })
                    vim.lsp.buf.format({
                        filter = function(_client)
                            if have_nls then
                                -- apply whatever logic you want (in this example, we'll only use null-ls)
                                return _client.name == "null-ls"
                            end
                            return _client.name ~= "null-ls"
                        end,
                        bufnr = bufnr,
                    })
                end, opts)
                keymap("v", "<leader>f", function()
                    local cbuf = vim.api.nvim_get_current_buf()
                    local ft = vim.api.nvim_get_option_value("filetype", {
                        buf = cbuf,
                    })
                    local have_nls = package.loaded["null-ls"]
                        and #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

                    -- vim.lsp.buf.format({ async = false })

                    vim.lsp.buf.format({
                        filter = function(_client)
                            if have_nls then
                                -- apply whatever logic you want (in this example, we'll only use null-ls)
                                return _client.name == "null-ls"
                            end
                            return _client.name ~= "null-ls"
                        end,
                        bufnr = bufnr,
                    })
                end, opts)
                keymap("n", "<space>o", function()
                    require("telescope.builtin").lsp_document_symbols()
                    -- vim.lsp.buf.document_symbol()
                end, opts)
                keymap("n", "<space>O", function()
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
                local status_ok, server_config = pcall(require, "lsp.languages." .. lsp)
                if status_ok then
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

                    opts = vim.tbl_deep_extend("force", opts, server_config)
                    lspconfig[lsp].setup(opts)
                end
            end
        end,
    },
    {
        "neoclide/coc.nvim",
        enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        branch = "release",
        config = function()
            -- Some servers have issues with backup files, see #649
            vim.opt.backup = false
            vim.opt.writebackup = false

            -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
            -- delays and poor user experience
            vim.opt.updatetime = 300

            -- Always show the signcolumn, otherwise it would shift the text each time
            -- diagnostics appeared/became resolved
            vim.opt.signcolumn = "yes"

            local keyset = vim.keymap.set
            -- Autocomplete
            function _G.check_back_space()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
            end

            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
            keyset(
                "i",
                "<TAB>",
                'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
                opts
            )
            keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            keyset(
                "i",
                "<cr>",
                [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
                opts
            )

            -- Use <c-j> to trigger snippets
            keyset("i", "<M-j>", "<Plug>(coc-snippets-expand-jump)")
            -- Use <c-space> to trigger completion
            keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

            -- Use `[g` and `]g` to navigate diagnostics
            -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
            keyset("n", "<M-j>", "<Plug>(coc-diagnostic-prev)", { silent = true })
            keyset("n", "<M-k>", "<Plug>(coc-diagnostic-next)", { silent = true })

            -- Add (Neo)Vim's native statusline support
            -- NOTE: Please see `:h coc-status` for integrations with external plugins that
            -- provide custom statusline: lightline.vim, vim-airline
            vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

            -- Mappings for CoCList
            -- code actions and coc stuff
            ---@diagnostic disable-next-line: redefined-local
            local opts = { silent = true, nowait = true }
            -- Show all diagnostics
            keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
            -- Manage extensions
            keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
            -- Show commands
            keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
            -- Find symbol of current document
            keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
            -- Search workspace symbols
            keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
            -- Do default action for next item
            keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
            -- Do default action for previous item
            keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
            -- Resume latest coc list
            keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
        end,
    },
}

return _M

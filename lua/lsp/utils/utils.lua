local M = {}

local function keymaps(_, bufnr)
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
    keymap("n", "<leader>D", function()
        vim.lsp.buf.type_definition()
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
            vim.lsp.buf.hover({ border = require("config").ui.float_ui_win.border })
        end
    end, opts)
    keymap("n", "<leader>rn", function()
        vim.lsp.buf.rename()
    end, opts)
    keymap("n", "?", function()
        vim.diagnostic.open_float()
    end, opts)
    keymap("n", "<m-j>", function()
        vim.diagnostic.jump({ count = 1, float = false })
    end, opts)
    keymap("n", "<m-k>", function()
        vim.diagnostic.jump({ count = -1, float = false })
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
        require("telescope.builtin").lsp_workspace_symbols()
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

local function lsp_highlight(client, bufnr)
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

M.capabilities = function()
    local capabilities_ = vim.lsp.protocol.make_client_capabilities()
    capabilities_.textDocument.foldingRange = {
        dynamicRegistration = true,
        lineFoldingOnly = true,
    }
    capabilities_.workspace.inlayHint.refreshSupport = true
    capabilities_.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = false,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
        },
    }
    capabilities_.textDocument.publishDiagnostics = {
        dataSupport = true,
        relevanceSupport = true,
    }
    capabilities_.textDocument.references = {
        dynamicRegistration = true,
    }
    return capabilities_
end

M.on_init = function(client, _)
    if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.on_attach = function(client, bufnr)
    keymaps(client, bufnr)
    lsp_highlight(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    client.capabilities.document_formatting = false -- ?
end

M.handlers = function()
    return {
        -- ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        --     border = require("config").ui.border,
        --     silent = true,
        --     -- focusable = false,
        -- }),
        -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        --     border = require("config").ui.border,
        --     silent = true,
        --     -- focusable = false,
        -- }),
    }
end

return M

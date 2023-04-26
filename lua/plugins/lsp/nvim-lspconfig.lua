----------------------------------------------------------------------
--                            lsp config                            --
----------------------------------------------------------------------
local lspconfig = require("lspconfig")
local handlers = {
    function(server_name) -- default handler (optional)
        if server_name ~= "jdtls" then
            local opts = {
                on_init = function(client, bufnr)
                end,
                on_attach = function(client, bufnr)
                end,
            }

            local status_ok, server = pcall(require, "plugins.lsp.languages." .. server_name)
            if status_ok then
                opts = vim.tbl_deep_extend("force", server, opts)
            end

            if server_name == "lua_ls" then
                lspconfig["sumneko_lua"].setup(opts)
            else
                lspconfig[server_name].setup(opts)
            end
        end
    end,
}

----------------------------------------------------------------------
--                           mason-config                           --
----------------------------------------------------------------------
local mason_lspconfig = require("mason-lspconfig")
local server_names = require("config").lsp_servers
mason_lspconfig.setup({
    ensure_installed = server_names,
    handlers = handlers,
})


----------------------------------------------------------------------
--                              keymap                              --
----------------------------------------------------------------------
local key_map_function = function(_, bufnr)
    local opts = { silent = true, noremap = true, buffer = bufnr }
    local keymap = vim.keymap.set

    keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
    keymap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
    -- keymap("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
    keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>", opts)
    keymap("n", "go", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>", opts)
    -- keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    -- keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    -- keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
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
    -- keymap("n", "<leader>f", function()
    --     local buf = vim.api.nvim_get_current_buf()
    --     local ft = vim.bo[buf].filetype
    --     local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
    --
    --     vim.lsp.buf.format({
    --         filter = function(client)
    --             if have_nls then
    --                 -- apply whatever logic you want (in this example, we'll only use null-ls)
    --                 return client.name == "null-ls"
    --             end
    --             return client.name ~= "null-ls"
    --         end,
    --     })
    -- end, opts)
    -- vim.keymap.set("v", "<leader>f", function()
    --     local buf = vim.api.nvim_get_current_buf()
    --     local ft = vim.bo[buf].filetype
    --     local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
    --
    --     vim.lsp.buf.format({
    --         filter = function(client)
    --             if have_nls then
    --                 -- apply whatever logic you want (in this example, we'll only use null-ls)
    --                 return client.name == "null-ls"
    --             end
    --             return client.name ~= "null-ls"
    --         end,
    --     })
    -- end, opts)
end

local lsp_highlight = function(client, bufnr)
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

require("utils").on_attach(key_map_function)
require("utils").on_attach(lsp_highlight)

local null_ls = require("null-ls")

local sources = {
    -- format
    null_ls.builtins.formatting.prettierd.with({
        filetypes = { "html", "yaml", "markdown", "json" },
    }),
    null_ls.builtins.formatting.stylua.with({
        extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
    }),
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.cmake_format,
    null_ls.builtins.formatting.google_java_format.with({ filetypes = { "java" } }),
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.clang_format.with({
        extra_args = { "--style", "{BasedOnStyle: Google, IndentWidth: 4}" },
    }),

    -- diagnostics
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.cppcheck,
    -- null_ls.builtins.diagnostics.clang_check,
    -- null_ls.builtins.diagnostics.cpplint.with({
    --     args = { "--filter=-whitespace/line_length,-whitespace/todo", "$FILENAME" },
    -- }),
    -- null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.shellcheck,

    -- codeaction
    -- null_ls.builtins.code_actions.gitrebase,
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,

    -- for bash
    null_ls.builtins.hover.dictionary,
    null_ls.builtins.hover.printenv,
}

-- format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

null_ls.setup({
    -- on_init = function(new_client, _)
    --     new_client.offset_encoding = "utf-16"
    -- end,
    debug = false,
    sources = sources,
    -- on_attach = on_attach,
})

----------------------------------------------------------------------
--                auto install linter and formatter                 --
----------------------------------------------------------------------
vim.defer_fn(function()
    local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
    if mason_null_ls_ok then
        mason_null_ls.setup({
            ensure_installed = nil,
            automatic_installation = true,
            automatic_setup = false,
        })
    else
        vim.notify("mason-null-ls not found")
    end
end, 10)

-- ----------------------------------------------------------------------
-- --                             key map                              --
-- ----------------------------------------------------------------------
-- local keymap_func = function(client, bufnr)
--     local opts = { silent = true, noremap = true }
--     -- local keymap = vim.api.nvim_set_keymap
--     -- keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = false})<cr>", opts)
--     -- keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
--
--     vim.keymap.set("n", "<leader>f", function()
--         local buf = vim.api.nvim_get_current_buf()
--         local ft = vim.bo[buf].filetype
--         local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
--
--         vim.lsp.buf.format({
--             filter = function(client)
--                 if have_nls then
--                     -- apply whatever logic you want (in this example, we'll only use null-ls)
--                     return client.name == "null-ls"
--                 end
--                 return client.name ~= "null-ls"
--             end,
--         })
--     end, opts)
--
--     vim.keymap.set("v", "<leader>f", function()
--         local buf = vim.api.nvim_get_current_buf()
--         local ft = vim.bo[buf].filetype
--         local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
--
--         vim.lsp.buf.format({
--             filter = function(client)
--                 if have_nls then
--                     -- apply whatever logic you want (in this example, we'll only use null-ls)
--                     return client.name == "null-ls"
--                 end
--                 return client.name ~= "null-ls"
--             end,
--         })
--     end, opts)
-- end
--
-- require("utils").on_attach(keymap_func)

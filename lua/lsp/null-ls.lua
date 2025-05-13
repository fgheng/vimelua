local _M = {
    "nvimtools/none-ls.nvim",
    enabled = false,
    -- dependencies = { "williamboman/mason.nvim", "jayp0521/mason-null-ls.nvim" },
    event = { "LspAttach" },
    config = function()
        local null_ls = require("null-ls")

        local sources = {
            -- format
            null_ls.builtins.formatting.prettierd.with({
                filetypes = { "html", "yaml", "markdown", "json" },
            }),
            null_ls.builtins.formatting["stylua"].with({
                extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            }),
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.cmake_format,
            -- null_ls.builtins.formatting.google_java_format.with({ filetypes = { "java" }, indent_size = 4 }),
            null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh" } }),
            -- null_ls.builtins.formatting.clang_format.with({
            --     -- extra_args = { "--style", "{BasedOnStyle: Google, IndentWidth: 4}" },
            --     extra_args = { "--style", "file" },
            -- }),

            -- diagnostics
            -- null_ls.builtins.diagnostics.write_good,
            -- null_ls.builtins.diagnostics.cppcheck,
            -- null_ls.builtins.diagnostics.shellcheck,

            -- codeaction
            -- null_ls.builtins.code_actions.shellcheck,

            -- for bash
            null_ls.builtins.hover.dictionary,
            null_ls.builtins.hover.printenv,
        }

        null_ls.setup({
            -- on_init = function(new_client, _)
            --     new_client.offset_encoding = "utf-16"
            -- end,
            debug = false,
            sources = sources,
            -- on_attach = function(client, bufnr)
            -- keymap(client, bufnr)
            -- auto_save(client, bufnr)
            -- end,
        })

        -- ----------------------------------------------------------------------
        -- --                auto install linter and formatter                 --
        -- ----------------------------------------------------------------------
        -- vim.defer_fn(function()
        --     local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
        --     if mason_null_ls_ok then
        --         mason_null_ls.setup({
        --             ensure_installed = nil,
        --             automatic_installation = true,
        --             automatic_setup = false,
        --         })
        --     else
        --         vim.notify("mason-null-ls not found")
        --     end
        -- end, 10)
    end,
    -- keys = {
        -- {
        --     mode = "n",
        --     "<leader>f",
        --     function()
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
        --             async = false,
        --             timeout = 0,
        --         })
        --     end,
        -- },
        -- {
        --     mode = "v",
        --     "<leader>f",
        --     function()
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
        --             async = false,
        --             timeout = 0,
        --         })
        --     end,
        -- },
    -- },
}

return _M

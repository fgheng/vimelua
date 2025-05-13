return {
    'stevearc/conform.nvim',
    enabled = false,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                sh = { "shfmt" },
                -- Conform will run multiple formatters sequentially
                python = { "black", "isort" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },

                -- Use the "*" filetype to run formatters on all filetypes.
                ["*"] = { "codespell" },
                -- Use the "_" filetype to run formatters on filetypes that don't
                -- have other formatters configured.
                ["_"] = { "trim_whitespace" },
            },
        })
    end
}

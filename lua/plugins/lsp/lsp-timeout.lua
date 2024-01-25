vim.g.lspTimeoutConfig = {
    stopTimeout = 1000, -- Stop unused lsp servers after 1s (for testing).
    startTimeout = 2000, -- Force server restart if nvim can't in 2s.
    silent = false, -- Notifications disabled
    filetypes = { -- Exclude servers that miss behave on LSP stop/start.
        ignore = { "markdown", "java" },
    },
}

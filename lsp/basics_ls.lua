return {
    on_init = require("utils.lsp_utils").on_init,
    on_attach = require("utils.lsp_utils").on_attach,
    capabilities = require("utils.lsp_utils").capabilities,
    handlers = require("utils.lsp_utils").handlers,
    settings = {
        buffer = {
            enable = true,
            minCompletionLength = 4, -- only provide completions for words longer than 4 characters
            matchStrategy = "exact", -- or 'fuzzy'
        },
        path = {
            enable = true,
        },
        snippet = {
            enable = true,
            sources = { require("config").snippet_path }, -- paths to package containing snippets, see examples below
            matchStrategy = "fuzzy", -- or 'fuzzy'
        },
    },
}

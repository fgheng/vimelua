return {
    on_init = require("utils.lsp_utils").on_init,
    on_attach = require("utils.lsp_utils").on_attach,
    capabilities = require("utils.lsp_utils").capabilities,
    handlers = require("utils.lsp_utils").handlers,
    cmd = { "delance-langserver", "--stdio" }, -- using pylance, install pylance by `npm install -g @delance/runtime`
    -- cmd = { "pyright-langserver", "--stdio" },
    single_file_support = true,
    settings = {
        verboseOutput = true,
        autoImportCompletion = true,
        python = {
            analysis = {
                autoSearchPaths = true,
                -- typeCheckingMode = "strict",
                inlayHints = {
                    callArgumentNames = "partial",
                    functionReturnTypes = true,
                    pytestParameters = true,
                    variableTypes = true,
                },
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                indexing = true,
            },
        },
    },
    format = {
        enable = true,
    }
    -- formatter = "black",
    -- formatting = {
    --     provider = "black"
    -- }
}

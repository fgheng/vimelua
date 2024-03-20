return {
    cmd = { "delance-langserver", "--stdio" }, -- using pylance, install pylance by `npm install -g @delance/runtime`
    settings = {
        verboseOutput = true,
        autoImportCompletion = true,
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "strict",
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
}

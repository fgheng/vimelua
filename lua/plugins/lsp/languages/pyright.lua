return {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "on",
                inlayHints = {
                    functionReturnTypes = true,
                    pytestParameters = true,
                    variableTypes = true,
                    callArgumentNames = "partial"
                },
            },
        },
    },
}

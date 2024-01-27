return {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "off",
                inlayHints = {
                    callArgumentNames = "partial",
                    functionReturnTypes = true,
                    pytestParameters = true,
                    variableTypes = true,
                },
            },
        },
    },
}

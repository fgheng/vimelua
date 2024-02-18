return {
    cmd = {"delance-langserver", "--stdio"}, -- using pylance, install pylance by `npm install -g @delance/runtime`
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

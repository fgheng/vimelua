return {
    cmd = {
        "jdtls",
        "-data",
        vim.fn.getcwd() .. "/../java-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
    },
    root_dir = lspconfig.util.root_pattern(
        ".git",
        "pom.xml",
        "build.xml",
        "settings.gradle",
        "settings.gradle.kts",
        vim.fn.getcwd()
    ),
    single_file_support = true,
}

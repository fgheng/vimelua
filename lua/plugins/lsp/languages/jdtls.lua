local lspconfig = require("lspconfig")

local data_path = vim.fn.stdpath("data")
local configuration = data_path .. "/mason/packages/jdtls"
if vim.fn.has("mac") == 1 then
    configuration = configuration .. "/config_mac"
elseif vim.fn.has("unix") == 1 then
    configuration = configuration .. "/config_linux"
else
    vim.notify("Unsupported system")
    return
end

local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/java-workspace/" .. project_name

local _M = {
    cmd = {
        "jdtls",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        vim.fn.glob(data_path .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

        "-configuration",
        configuration,

        "-data",
        -- vim.fn.getcwd() .. "/../java-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
        workspace_dir,
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

return _M

-- local lspconfig = require("lspconfig")

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
local workspace_dir = home .. "/.cache/jdtls3/workspace/" .. project_name

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
    -- cmd = {
    --
    --     -- 💀
    --     "java", -- or '/path/to/java21_or_newer/bin/java'
    --     -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    --
    --     "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    --     "-Dosgi.bundles.defaultStartLevel=4",
    --     "-Declipse.product=org.eclipse.jdt.ls.core.product",
    --     "-Dlog.protocol=true",
    --     "-Dlog.level=ALL",
    --     "-Xmx1g",
    --     "--add-modules=ALL-SYSTEM",
    --     "--add-opens",
    --     "java.base/java.util=ALL-UNNAMED",
    --     "--add-opens",
    --     "java.base/java.lang=ALL-UNNAMED",
    --
    --     -- 💀
    --     "-jar",
    --     vim.fn.glob(data_path .. "/mason/packages/jdtls/")
    --         .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
    --     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    --     -- Must point to the                                                     Change this to
    --     -- eclipse.jdt.ls installation                                           the actual version
    --
    --     -- 💀
    --     "-configuration",
    --     vim.fn.glob(data_path .. "/mason/packages/jdtls/") .. "/config_mac",
    --     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    --     -- Must point to the                      Change to one of `linux`, `win` or `mac`
    --     -- eclipse.jdt.ls installation            Depending on your system.
    --
    --     -- 💀
    --     -- See `data directory configuration` section in the README
    --     "-data",
    --     workspace_dir,
    -- },
    root_dir = vim.fs.root(0, {
        ".git",
        "pom.xml",
        "build.xml",
        "settings.gradle",
        "settings.gradle.kts",
        vim.fn.getcwd(),
    }),
    single_file_support = true,
    -- root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
}

return _M

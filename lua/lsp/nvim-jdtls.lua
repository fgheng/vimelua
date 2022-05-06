return {
    "mfussenegger/nvim-jdtls",
    enabled = true,

    ft = { "java" },

    config = function()
        local data_path = vim.fn.stdpath("data")

        local home = os.getenv("HOME")
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        -- 💀
        local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
        -- local mason_registry = require("mason-registry")
        -- local jdtls_pkg = mason_registry.get_package("jdtls")
        -- local jdtls_path = jdtls_pkg:get_install_path()
        local jdtls_path = data_path .. "/mason/packages/jdtls/"
        -- 💀
        local lancher_jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
        -- 💀
        local CONFIG = "linux"
        if vim.fn.has "mac" == 1 then
            CONFIG = "mac"
        elseif vim.fn.has "unix" == 1 then
            CONFIG = "linux"
        else
            CONFIG = "win"
        end
        local config_path = jdtls_path .. "/config_" .. CONFIG -- config_linux config_mac config_win

        local config = {
            cmd = {

                "java", -- or '/path/to/java21_or_newer/bin/java'
                -- depends on if `java` is in your $PATH env variable and if it points to the right version.

                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-Xmx1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens",
                "java.base/java.util=ALL-UNNAMED",
                "--add-opens",
                "java.base/java.lang=ALL-UNNAMED",

                "-jar",
                lancher_jar,
                "-configuration",
                config_path,
                "-data",
                workspace_dir,
            },

            root_dir = vim.fs.root(0,{ ".git", "mvnw", "gradlew" }),

            -- Here you can configure eclipse.jdt.ls specific settings
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- for a list of options
            settings = {
                java = {},
            },

            -- Language server `initializationOptions`
            -- You need to extend the `bundles` with paths to jar files
            -- if you want to use additional eclipse.jdt.ls plugins.
            --
            -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
            --
            -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
            init_options = {
                bundles = {},
            },
            capabilities = require("lsp.utils.utils").capabilities(),
            on_attach = require("lsp.utils.utils").on_attach,
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                require("jdtls").start_or_attach(config)
            end,
        })


        vim.api.nvim_create_user_command("JdtOrganizeImports", function()
            require('jdtls').organize_imports()
        end, {})
        vim.api.nvim_create_user_command("JdtExtractVariable", function()
            require('jdtls').extract_variable()
        end, {})
        vim.api.nvim_create_user_command("JdtExtractConstant", function()
            require('jdtls').extract_constant()
        end, {})
        vim.api.nvim_create_user_command("JdtExtractMethod", function()
            require('jdtls').extract_method()
        end, {})
        vim.api.nvim_create_user_command("JdtTestClass", function()
            require('jdtls').test_class()
        end, {})
        vim.api.nvim_create_user_command("JdtTestNearestMethod", function()
            require('jdtls').test_nearest_method()
        end, {})
    end,
}

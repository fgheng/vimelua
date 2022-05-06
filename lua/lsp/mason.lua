local masonpath = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = masonpath .. ":" .. vim.env.PATH

local _M = {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonAutoInstall"},
    config = function()
        local map_to_server = {
            lsp_servers = {
                lua_ls = "lua-language-server",
                rust_analyzer = "rust-analyzer",
                bashls = "bash-language-server",
                buf_ls = "buf-language-server",
                denols = "deno",
                jsonls = "json-lsp",
            },
            linter = {
                write_good = "write-good",
                cmake = "cmakelang",
            },
            formatter = {
                cmake_format = "cmakelang",
                google_java_format = "google-java-format",
                clang_format = "clang-format",
            },
            dap = {},
        }

        local ensure_installed = {}
        for k, v in pairs(require("config").servers) do
            local mts = map_to_server[k] or nil
            if mts ~= nil then
                for _, iv in ipairs(v) do
                    table.insert(ensure_installed, mts[iv] or iv)
                end
            end
        end

        require("mason").setup({
            ensure_installed = ensure_installed,
            max_concurrent_installers = 10,
            ui = {
                ---@since 1.0.0
                -- Whether to automatically check for new versions when opening the :Mason window.
                check_outdated_packages_on_open = true,

                ---@since 1.0.0
                -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
                border = require("config").ui.float_ui_win.border,
                width = require("config").ui.float_ui_win.width,
                height = require("config").ui.float_ui_win.height,
            },
            keymaps = {
                toggle_package_install_log = "o",
                toggle_package_expand = "o",
            }
        })

        vim.api.nvim_create_user_command("MasonAutoInstall", function()
            if #ensure_installed > 0 then
                local ensure_installed_str = ""
                for _, v in ipairs(ensure_installed) do
                    if not require("mason-registry").is_installed(v) then
                        ensure_installed_str = ensure_installed_str .. v .. " "
                    end
                end

                if ensure_installed_str == "" then
                    vim.notify("All packages are already installed")
                else
                    vim.api.nvim_command('MasonInstall ' .. ensure_installed_str)
                end
            end
        end, {})

        vim.g.mason_binaries_list = ensure_installed
    end,
}
return _M

local masonpath = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = masonpath .. ":" .. vim.env.PATH

local _M = {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = function()
        local map_to_server = {
            lsp_servers = {
                lua_ls = "lua-language-server",
                rust_analyzer = "rust-analyzer",
                bashls = "bash-language-server",
                bufls = "buf-language-server",
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
        })

        vim.api.nvim_create_user_command("MasonInstallAll", function()
            if #ensure_installed > 0 then
                -- vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
                vim.api.nvim_command('MasonInstall ' .. table.concat(ensure_installed, ' '))
            end
        end, {})

        vim.g.mason_binaries_list = ensure_installed
    end,
}
return _M

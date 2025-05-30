M = {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
            -- require("lazydev").setup({
            --     library = { "nvim-dap-ui" },
            -- })
            require("dapui").setup({})
            vim.api.nvim_create_user_command("Debug", function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
                end
                require("dapui").toggle()
            end, {})
            vim.api.nvim_create_user_command("De", function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
                end
                require("dapui").toggle()
            end, {})
            vim.api.nvim_create_user_command("Dd", function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
                end
                require("dapui").toggle()
            end, {})
        end,
        cmd = {
            "Debug", "De", "Dd"
        }
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
        end
    }
}

return M

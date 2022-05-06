local _M = {
    "stevearc/dressing.nvim",
    enabled = true,
    event = "BufReadPre",
    init = function()
        -- vim.ui.select = function(...)
        --     require("lazy").load({ plugins = { "dressing.nvim" } })
        --     return vim.ui.select(...)
        -- end

        vim.ui.input = function(...)
            require("lazy").load({ plugins = { "dressing.nvim" } })
            return vim.ui.input(...)
        end
    end,
}
return _M

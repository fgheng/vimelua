local _M = {
    "karb94/neoscroll.nvim",
    enabled = true,
    config = function()
        require("neoscroll").setup({
            performance_mode = true,
        })

        local t = {
            -- Syntax: t[keys] = {function, {function arguments}}
            ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } },
            ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } },
            ["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "250" } },
            ["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "250" } },
            ["<C-y>"] = { "scroll", { "-0.10", "false", "100" } },
            ["<C-e>"] = { "scroll", { "0.10", "false", "100" } },
            ["zt"] = { "zt", { "100" } },
            ["zz"] = { "zz", { "100" } },
            ["zb"] = { "zb", { "100" } },
        }

        require("neoscroll.config").set_mappings(t)
    end,
    keys = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
    },
}
return _M

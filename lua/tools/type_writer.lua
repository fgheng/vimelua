local _M = {
    {
        "joshuadanpeterson/typewriter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("typewriter").setup()
        end,
        opts = {},
        cmd = { "TWEnable", "TWCenter", "TWTop", "TWBottom" },
    },
}

return _M

local _M = {
    "nvim-lua/plenary.nvim",
    lazy = true,
    keys = {
        {
            "<leader>pp",
            function()
                require("plenary.profile").start("profile.log", { flame = true })
            end,
            desc = "Begin profiling",
        },
        {
            "<leader>ps",
            function()
                require("plenary.profile").stop()
            end,
            desc = "End profiling",
        },
    },
}
return _M

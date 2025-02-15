return {
    {
        "AckslD/nvim-neoclip.lua",
        enabled = false,
        dependencies = {
            -- you'll need at least one of these
            { "nvim-telescope/telescope.nvim" },
            -- {'ibhagwan/fzf-lua'},
        },
        config = function()
            require("neoclip").setup({
                history = 1000,
                enable_persistent_history = true,
            })
        end,
    },
}

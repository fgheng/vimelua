require("persistence").setup({
    -- dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    options = {
        "buffers",
        "curdir",
        "tabpages",
        "winsize",
        "help",
    },
})
----------------------------------------------------------------------
--                              keymap                              --
----------------------------------------------------------------------
vim.defer_fn(function()
    local opts = { silent = true, noremap = true }
    local keymap = vim.api.nvim_set_keymap

    keymap("n", "<leader>ss", '<cmd>lua require("persistence").load()<cr>', opts)
    keymap("n", "<leader>sl", '<cmd>lua require("persistence").load({last = true})<cr>', opts)
    keymap("n", "<leader>sd", '<cmd>lua require("persistence").stop()<cr>', opts)
end, 10)

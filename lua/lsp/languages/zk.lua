return {
    cmd = { "zk", "lsp" },
    name = "zk",
    on_attach = function(_, bufnr)
        local opts = { silent = true, noremap = true, buffer = bufnr }
        local keymap = vim.keymap.set

        keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
        keymap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
    end,
}

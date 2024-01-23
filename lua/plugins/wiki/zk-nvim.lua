-- export ZK_NOTEBOOK_DIR=/your/note/path

require("zk").setup({
    -- See Setup section below
    picker = "telescope",

    lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
        },
    },
})

local notebook_dir = os.getenv("ZK_NOTEBOOK_DIR")
local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<space>zl", function()
    vim.api.nvim_command("ZkNotes")
end, opts)
vim.keymap.set("n", "<space>zt", function()
    vim.api.nvim_command("ZkTags")
end, opts)
vim.keymap.set("n", "<space>zn", function()
    vim.ui.input({ prompt = "title: ", default = "" }, function(input)
        if input ~= nil then
            local options = {
                path = notebook_dir .. "/" .. input,
                title = input,
            }
            require("zk").new(options)
        end
    end)
end, opts)
vim.keymap.set("v", "<space>zs", ":'<,'>ZkMatch<CR>", opts)

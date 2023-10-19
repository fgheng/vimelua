
-- if not status_ok then
--     vim.notify('diffview not found')
--     return
-- end

require("diffview").setup({
    use_icons = false,
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
vim.keymap.set("n", "<leader>gd", function()
    vim.ui.input({ prompt = "commit: ", default = "" }, function(input)
        if input ~= nil then
            vim.api.nvim_command("DiffviewOpen " .. input)
        end
    end)
end, opts)

keymap("n", "<leader>gc", "<cmd>DiffviewClose<cr>", opts)
keymap("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", opts)

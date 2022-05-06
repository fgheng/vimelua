local status_ok, hover = pcall(require, 'hover')
if not status_ok then
    vim.notify('hover not found')
    return
end

hover.setup({
    init = function()
        -- Require providers
        require("hover.providers.lsp")
        -- require('hover.providers.gh')
        -- require('hover.providers.jira')
        -- require('hover.providers.man')
        -- require('hover.providers.dictionary')
    end,
    preview_opts = {
        border = nil
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = true,
    title = true
})

local keymap = vim.api.nvim_set_keymap
keymap("n", "K", "lua require('hover').hover", { desc = "hover.nvim" })
-- keymap("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

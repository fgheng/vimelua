-- local status_ok, surround = pcall(require, "surround")
-- if not status_ok then
--     vim.notify("surround not found")
--     return
-- end

require("surround").setup({
    mappings_style = "surround",
    space_on_closing_char = false,
})

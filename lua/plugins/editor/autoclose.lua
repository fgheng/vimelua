local status_ok, autoclose = pcall(require, "autoclose")
if not status_ok then
    vim.notify("autoclose not found")
    return
end

autoclose.setup({
    -- ["$"] = { escape = true, close = true, pair = "$$" },
    -- [">"] = { escape = false, close = false, pair = "<>" },
    ["<CR>"] = {},
})

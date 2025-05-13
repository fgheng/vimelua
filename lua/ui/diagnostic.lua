local fn = vim.fn
local diagnostic = vim.diagnostic

local icons = require("utils.icons")
local signs = {
    Error = icons.symbols.error .. " ",
    Warn = icons.symbols.warning .. " ",
    Hint = icons.symbols.hint .. " ",
    Info = icons.symbols.info .. " ",
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
    virtual_text = true,
    -- virtual_text = {
    --     source = "if_many", -- "always" Or "if_many"
    --     prefix = icons.icons.square .. " ",
    --     -- suffix = function(diag)
    --     --     if diag.severity == vim.diagnostic.severity.ERROR then
    --     --         return string.format(" [error]")
    --     --     elseif diag.severity == vim.diagnostic.severity.HINT then
    --     --         return string.format(" [hint]")
    --     --     else
    --     --         return string.format(" [info]")
    --     --     end
    --     -- end,
    --     spacing = 4,
    --     format = function(diag)
    --         if diag.severity == vim.diagnostic.severity.ERROR then
    --             return string.format("[error] %s", diag.message)
    --         elseif diag.severity == vim.diagnostic.severity.HINT then
    --             return string.format("[hint] %s", diag.message)
    --         else
    --             return string.format("[info] %s", diag.message)
    --         end
    --     end,
    -- },
    -- virtual_lines = {
    --     only_current_line = false,
    -- },
    signs = false,
    -- signs = {
    --  active = false,
    -- },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        -- style = "minimal",
        border = require("config").ui.float_ui_win.border,
        source = "if_many",
        header = "",
        prefix = "",
    },
}
diagnostic.config(config)

return {}

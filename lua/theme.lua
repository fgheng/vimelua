local api = vim.api
local fn = vim.fn
local highlight = vim.highlight
local diagnostic = vim.diagnostic
local lsp = vim.lsp

----------------------------------------------------------------------
--                          highlight yank                          --
----------------------------------------------------------------------
local highlight_group = api.nvim_create_augroup('vimeGroup_YankHighlight', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

----------------------------------------------------------------------
--                            diagnostic                            --
----------------------------------------------------------------------
local icons_signs = require('plugins.theme.icons').signs
local signs = {
    Error = icons_signs.error,
    Warn = icons_signs.warning,
    Hint = icons_signs.hint,
    Info = icons_signs.info
}
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
    virtual_text = true,
    signs = {
        active = true
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}
diagnostic.config(config)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
    border = "rounded",
})
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
    border = "rounded",
})

----------------------------------------------------------------------
--                           colorscheme                            --
----------------------------------------------------------------------
local colorscheme = require('config').colorscheme
if colorscheme.light then
    vim.cmd[[set background=light]]
else
    vim.cmd[[set background=dark]]
end
local status_ok = pcall(vim.cmd, 'colorscheme ' .. colorscheme.theme)
if not status_ok then
    vim.notify('The theme "' .. colorscheme.theme .. '" not found')
end

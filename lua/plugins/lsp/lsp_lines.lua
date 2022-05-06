-- local status_ok, lsp_lines = pcall(require, "lsp_lines")
-- if not status_ok then
-- 	vim.notify("lsp_lines not found")
-- 	return
-- end

require("lsp_lines").setup({})
vim.diagnostic.config({
    virtual_text = true,
})

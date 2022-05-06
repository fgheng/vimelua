local status_ok, ccc = pcall(require, "ccc")
if not status_ok then
	vim.notify("ccc.nvim not found")
	return
end

vim.o.termguicolors = true
ccc.setup({})

local status_ok, popui = pcall(require, "popui")
if not status_ok then
	vim.notify("popui not found")
	return
end

popui.setup({})
vim.ui.select = require("popui.ui-overrider")
vim.ui.input = require("popui.input-overrider")
vim.api.nvim_set_keymap("n", ",d", ':lua require"popui.diagnostics-navigator"()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true })

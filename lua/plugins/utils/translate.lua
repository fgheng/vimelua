local status_ok, translate = pcall(require, "translate")
if not status_ok then
	vim.notify("translate not found")
	return
end

translate.setup({
	default = {
		command = "deepl_pro",
	},
	preset = {
		output = {
			split = {
				append = true,
			},
		},
	},
})

vim.api.nvim_set_keymap("n", ";t", "<cmd>lua require('translate').translate<cr>")

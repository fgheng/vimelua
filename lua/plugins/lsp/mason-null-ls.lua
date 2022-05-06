local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")

if mason_null_ls_ok then
	mason_null_ls.setup({
		ensure_installed = nil,
		automatic_installation = true,
		automatic_setup = false,
	})
else
	vim.notify("mason-null-ls not found")
end

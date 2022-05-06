-- local status_ok, renamer = pcall(require, "renamer")
-- if not status_ok then
-- 	vim.notify("renamer not found")
-- 	return
-- end

require("renamer").setup({})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>rn", '<cmd>lua require("renamer").rename()<cr>', opts)

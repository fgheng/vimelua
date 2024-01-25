local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<m-x>", '<cmd>lua require("bufdelete")bufdelete(0, true)<cr>', opts)

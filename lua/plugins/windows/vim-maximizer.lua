
local cmd = vim.api.nvim_command
local status_ok, shade = pcall(require, 'shade')

local function maximizer_with_shade()
    shade.toggle()
    cmd [[MaximizerToggle]]
    shade.toggle()
end

local function maximizer()
    cmd [[MaximizerToggle]]
end

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<c-w>o', function ()
    if status_ok then
        maximizer_with_shade()
    else
        maximizer()
    end
end, opts)

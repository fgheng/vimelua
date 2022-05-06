local status_ok, be = pcall(require, 'better_escape')
if not status_ok then
    vim.notify('better-escape not found')
    return
end

be.setup({
    mapping = { 'jk' }, -- a table with mappings to use
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = '<Esc>', -- keys used for escaping, if it is a function will use the result every time
})

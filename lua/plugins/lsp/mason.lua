local status_ok, mason = pcall(require, 'mason')
if not status_ok then
    vim.notify('mason not found')
    return
end

mason.setup({})

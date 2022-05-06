local status_ok, notify = pcall(require, 'notify')
if not status_ok then
    vim.notify('nvim-notify not found')
    return
end

notify.setup({
    render = 'default',
    stages = 'fade', -- default fade_in_slide_out
    max_width = 150,
    timeout = 3000,
})

vim.notify = notify

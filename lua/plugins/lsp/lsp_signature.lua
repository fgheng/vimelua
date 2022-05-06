local status_ok, lsp_signature = pcall(require, 'lsp_signature')
if not status_ok then
    vim.notify('lsp-signature not found')
    return
end

lsp_signature.setup({
    handler_opts = {
        bind = true,
        -- double, rounded, single, shadow, none
        -- double 显示提示和注释
        border = 'rounded',
    },
    hint_enable = false, -- 去掉熊猫头
    floating_window = true,
    floating_window_above_cur_line = true,
    extra_trigger_chars = {'(', ','},
})

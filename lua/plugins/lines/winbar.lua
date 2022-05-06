local status_ok, winbar = pcall(require, 'winbar')

if not status_ok then
    vim.notify('winbar.nvim not found')
    return
end

winbar.setup({
    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
        path = '#d08770',
        file_name = '#aa0000',
        -- symbols = '',
    },

    icons = {
        -- seperator = '>',
        -- editor_state = '●',
        -- lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
        'floaterm'
    }
})

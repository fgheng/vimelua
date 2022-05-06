local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    vim.notify('nvim-tree not found')
    return
end

local icons_signs = require('plugins.theme.icons').signs
local icons_git = require('plugins.theme.icons').git

local custom_key = {
    { key = { 'o', '<2-LeftMouse>', 'l' }, action = 'edit' },
    { key = { '<2-RightMouse>', '<CR>' }, action = 'cd' },
    { key = '<BS>', action = 'dir_up' },

    { key = '<C-v>', action = 'vsplit' },
    { key = '<C-s>', action = 'split' },
    { key = '<C-t>', action = 'tabnew' },

    { key = '<leader>gk', action = 'prev_git_item' },
    { key = '<leader>gj', action = 'next_git_item' },
    { key = 'gk', action = 'prev_sibling' },
    { key = 'gj', action = 'next_sibling' },
    { key = 'h', action = 'close_node' },
    { key = '.', action = 'toggle_dotfiles' },
    { key = 'r', action = 'refresh' },
    { key = 'H', action = 'parent_node' },

    { key = 'A', action = 'create' },
    { key = 'D', action = 'remove' },
    { key = 'R', action = 'rename' },
    -- { key = '<C-r>', action = 'full_rename' },
    { key = 'dd', action = 'cut' },
    { key = 'yy', action = 'copy' },
    { key = 'P', action = 'paste' },
    { key = 'yn', action = 'copy_name' },
    { key = 'yp', action = 'copy_path' },
    -- { key = 'yy', action = 'copy_absolute_path' },

    { key = '<c-x>', action = 'system_open' },
    { key = 'q', action = 'close' },
    { key = '?', action = 'toggle_help' },
    { key = 's', action = 'search_node' },
    { key = 'K', action = 'toggle_file_info' },
    { key = 'x', action = 'run_file_command' }
}

nvim_tree.setup({
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    sort_by = 'name',
    update_cwd = true,
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = 'left',
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = 'yes',
        mappings = {
            custom_only = true,
            list = custom_key,
        },
    },
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = '└ ',
                edge = '│ ',
                none = '  ',
            },
        },
        icons = {
            webdev_colors = true,
            glyphs = {
                git = {
                    unstaged = icons_git.unstaged,
                    staged = icons_git.staged,
                    unmerged = icons_git.unmerged,
                    renamed = icons_git.renamed,
                    untracked = icons_git.untracked,
                    deleted = icons_git.deleted,
                    ignored = icons_git.ignored,
                },
                folder = {
                    default = '',
                    open = '',
                    empty = '',
                    empty_open = '',
                    symlink = '',
                },
            }
        },
    },
    hijack_directories = {
        enable = false,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = { 'help' },
    },
    ignore_ft_on_setup = {
        'startify',
        'dashboard',
        'alpha'
    },
    system_open = {
        cmd = '',
        args = {},
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = icons_signs.hint,
            info = icons_signs.info,
            warning = icons_signs.warning,
            error = icons_signs.error
        },
    },
    filters = {
        dotfiles = true,
        custom = { '.git' },
        exclude = { '.gitignore' },
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
                exclude = {
                    filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
                    buftype = { 'nofile', 'terminal', 'help' },
                },
            },
        },
    },
    trash = {
        cmd = 'trash',
        require_confirm = true,
    },
})

local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<F2>', '<cmd>NvimTreeToggle<cr>', opts)

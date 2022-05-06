local nvim_tree = require("nvim-tree")
local icons = require("ui.icons")

local custom_key = {
    { key = { "o", "<2-LeftMouse>", "l" }, action = "edit" },
    { key = { "<2-RightMouse>", "<CR>" }, action = "cd" },
    { key = "cd", action = "change_dir" },
    { key = "<BS>", action = "dir_up" },

    { key = "<C-v>", action = "vsplit" },
    { key = "<C-s>", action = "split" },
    { key = "<C-t>", action = "tabnew" },

    { key = "gk", action = "prev_git_item" },
    { key = "gj", action = "next_git_item" },
    { key = "[", action = "prev_sibling" },
    { key = "]", action = "next_sibling" },
    { key = "h", action = "close_node" },
    { key = ".", action = "toggle_dotfiles" },
    { key = "r", action = "refresh" },
    { key = "H", action = "parent_node" },

    { key = "A", action = "create" },
    { key = "D", action = "remove" },
    { key = "R", action = "rename" },
    -- { key = '<C-r>', action = 'full_rename' },
    { key = "dd", action = "cut" },
    { key = "yy", action = "copy" },
    { key = "P", action = "paste" },
    { key = "yn", action = "copy_name" },
    { key = "yp", action = "copy_path" },
    -- { key = 'yy', action = 'copy_absolute_path' },

    { key = "<c-x>", action = "system_open" },
    { key = "q", action = "close" },
    { key = "<esc>", action = "close" },
    { key = "?", action = "toggle_help" },
    { key = "s", action = "search_node" },
    { key = "K", action = "toggle_file_info" },
    { key = "x", action = "run_file_command" },

    { key = "f", action = "live_filter" },
    { key = "F", action = "clear_live_filter" },
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
    sort_by = "name",
    update_cwd = false,
    view = {
        adaptive_size = false,
        centralize_selection = true,
        cursorline = true,
        debounce_delay = 15,
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
        mappings = {
            custom_only = true,
            list = custom_key,
        },
        float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
                relative = "cursor",
                border = "rounded",
                width = 30,
                height = 30,
                row = 1,
                col = 1,
            },
        },
    },
    renderer = {
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
            glyphs = {
                git = {
                    unstaged = icons.git_unstaged,
                    staged = icons.git_staged,
                    unmerged = icons.git_unmerged,
                    renamed = icons.git_renamed,
                    untracked = icons.git_untracked,
                    deleted = icons.git_deleted,
                    ignored = icons.git_ignored,
                },
                folder = {
                    default = icons.folder,
                    open = icons.folder_open,
                    empty = icons.folder_empty,
                    empty_open = icons.folder_empty_open,
                    symlink = icons.file_link,
                },
            },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
    },
    hijack_directories = {
        enable = false,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = { "help" },
    },
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    system_open = {
        cmd = "",
        args = {},
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = icons.hint,
            info = icons.info,
            warning = icons.warning,
            error = icons.error,
        },
    },
    filters = {
        dotfiles = false,
        custom = { ".git" },
        exclude = { ".gitignore" },
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = false,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
            exclude = {},
        },
        file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
        },
        open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
})

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<F2>", "<cmd>NvimTreeToggle<cr>", opts)
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

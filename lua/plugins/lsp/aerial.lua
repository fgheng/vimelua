local status_ok, aerial = pcall(require, 'aerial')
if not status_ok then
    vim.notify('aerial not found')
    return
end

-- Call the setup function to change the default behavior
aerial.setup({
    -- Priority list of preferred backends for aerial.
    -- This can be a filetype map (see :help aerial-filetype-map)
    backends = { 'lsp', 'treesitter', 'markdown' },

    -- Enum: persist, close, auto, global
    close_behavior = 'global',

    -- Set to false to remove the default keybindings for the aerial buffer
    default_bindings = true,

    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = 'prefer_right',

    -- Disable aerial on files with this many lines
    disable_max_lines = 10000,

    -- Disable aerial on files this size or larger (in bytes)
    disable_max_size = 10000000,

    -- A list of all symbols to display. Set to false to display all symbols.
    -- This can be a filetype map (see :help aerial-filetype-map)
    -- To see all available values, see :help SymbolKind
    filter_kind = false,

    -- Enum: split_width, full_width, last, none
    highlight_mode = 'split_width',

    -- Highlight the closest symbol if the cursor is not exactly on one.
    highlight_closest = true,

    -- Highlight the symbol in the source buffer when cursor is in the aerial win
    highlight_on_hover = true,

    -- When jumping to a symbol, highlight the line for this many ms.
    -- Set to false to disable
    highlight_on_jump = 300,

    -- Define symbol icons. You can also specify '<Symbol>Collapsed' to change the
    -- icon when the tree is collapsed at that symbol, or 'Collapsed' to specify a
    -- default collapsed icon. The default icon set is determined by the
    -- 'nerd_font' option below.
    -- If you have lspkind-nvim installed, aerial will use it for icons.
    icons = {},

    ignore = {
        -- Ignore unlisted buffers. See :help buflisted
        unlisted_buffers = true,

        -- List of filetypes to ignore.
        filetypes = {},

        buftypes = 'special',

        wintypes = 'special',
    },

    -- When you fold code with za, zo, or zc, update the aerial tree as well.
    -- Only works when manage_folds = true
    link_folds_to_tree = false,

    -- Fold code when you open/collapse symbols in the tree.
    -- Only works when manage_folds = true
    link_tree_to_folds = true,

    -- Use symbol tree for folding. Set to true or false to enable/disable
    -- 'auto' will manage folds if your previous foldmethod was 'manual'
    manage_folds = false,

    -- These control the width of the aerial window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a list of mixed types.
    -- max_width = {40, 0.2} means 'the lesser of 40 columns or 20% of total'
    max_width = { 80, 0 },
    width = nil,
    min_width = 30,

    -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
    -- 'auto' will set it to true if nvim-web-devicons or lspkind-nvim is installed.
    nerd_font = 'auto',

    -- Call this function when aerial attaches to a buffer.
    -- Useful for setting keymaps. Takes a single `bufnr` argument.
    on_attach = nil,

    -- Automatically open aerial when entering supported buffers.
    -- This can be a function (see :help aerial-open-automatic)
    open_automatic = false,

    -- Set to true to only open aerial at the far right/left of the editor
    -- Default behavior opens aerial relative to current window
    placement_editor_edge = true,

    -- Run this command after jumping to a symbol (false will disable)
    post_jump_cmd = 'normal! zz',

    -- When true, aerial will automatically close after jumping to a symbol
    close_on_select = false,

    -- Show box drawing characters for the tree hierarchy
    show_guides = true,

    -- The autocmds that trigger symbols update (not used for LSP backend)
    update_events = 'TextChanged,InsertLeave',

    -- Customize the characters used when show_guides = true
    guides = {
        -- When the child item has a sibling below it
        mid_item = '├─',
        -- When the child item is the last in the list
        last_item = '└─',
        -- When there are nested child guides to the right
        nested_top = '│',
        -- Raw indentation
        whitespace = '',
    },

    -- Options for opening aerial in a floating win
    float = {
        -- Controls border appearance. Passed to nvim_open_win
        border = 'rounded',

        -- Enum: cursor, editor, win
        relative = 'cursor',

        -- These control the height of the floating window.
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },

        override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
        end,
    },

    lsp = {
        -- Fetch document symbols when LSP diagnostics update.
        -- If false, will update on buffer changes.
        diagnostics_trigger_update = false,

        -- Set to false to not update the symbols when there are LSP errors
        update_when_errors = true,

        -- How long to wait (in ms) after a buffer change before updating
        -- Only used when diagnostics_trigger_update = false
        update_delay = 300,
    },

    treesitter = {
        -- How long to wait (in ms) after a buffer change before updating
        update_delay = 300,
    },

    markdown = {
        -- How long to wait (in ms) after a buffer change before updating
        update_delay = 300,
    },
})

----------------------------------------------------------------------
--                    aerial config for lualine                     --
----------------------------------------------------------------------
-- TODO: aerial于lualine的配合需要考虑一下
-- local lualine = require('lualine')
-- local config = lualine.get_config()
--
-- table.insert(config.sections.lualine_c, aerial.get_location)
-- lualine.setup(config)

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<F3>', '<cmd>AerialToggle<cr>', opts)

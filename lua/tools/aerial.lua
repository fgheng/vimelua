local _M = {
    "stevearc/aerial.nvim", -- lspconfig, lualine
    enabled = true,
    cmd = { "AerialOpen", "AerialToggle" },
    opts = {
        -- Priority list of preferred backends for aerial.
        -- This can be a filetype map (see :help aerial-filetype-map)
        backends = { "lsp", "treesitter", "markdown", "man" },

        layout = {
            -- These control the width of the aerial window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_width and max_width can be a list of mixed types.
            -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
            max_width = { require("config").ui.sidebar_width, 0.2 },
            -- width = nil,
            width = require("config").ui.sidebar_width,
            min_width = { require("config").ui.sidebar_width, 0.2 },

            -- key-value pairs of window-local options for aerial window (e.g. winhl)
            win_opts = {},

            -- Determines the default direction to open the aerial window. The 'prefer'
            -- options will open the window in the other direction *if* there is a
            -- different buffer in the way of the preferred direction
            -- Enum: prefer_right, prefer_left, right, left, float
            default_direction = "prefer_left",

            -- Determines where the aerial window will be opened
            --   edge   - open aerial at the far right/left of the editor
            --   window - open aerial to the right/left of the current window
            placement = "edge",
        },

        lazy_load = true,
        -- Disable aerial on files with this many lines
        disable_max_lines = 10000,

        -- Disable aerial on files this size or larger (in bytes)
        disable_max_size = 2000000, -- Default 2MB

        -- A list of all symbols to display. Set to false to display all symbols.
        -- This can be a filetype map (see :help aerial-filetype-map)
        -- To see all available values, see :help SymbolKind
        filter_kind = false,

        -- Determines line highlighting mode when multiple splits are visible.
        -- split_width   Each open window will have its cursor location marked in the
        --               aerial buffer. Each line will only be partially highlighted
        --               to indicate which window is at that location.
        -- full_width    Each open window will have its cursor location marked as a
        --               full-width highlight in the aerial buffer.
        -- last          Only the most-recently focused window will have its location
        --               marked in the aerial buffer.
        -- none          Do not show the cursor locations in the aerial window.
        highlight_mode = "split_width",

        -- Highlight the closest symbol if the cursor is not exactly on one.
        highlight_closest = true,

        -- Highlight the symbol in the source buffer when cursor is in the aerial win
        highlight_on_hover = false,

        -- When jumping to a symbol, highlight the line for this many ms.
        -- Set to false to disable
        highlight_on_jump = 300,

        -- Define symbol icons. You can also specify '<Symbol>Collapsed' to change the
        -- icon when the tree is collapsed at that symbol, or 'Collapsed' to specify a
        -- default collapsed icon. The default icon set is determined by the
        -- 'nerd_font' option below.
        -- If you have lspkind-nvim installed, aerial will use it for icons.
        -- icons = icons.kind,

        ignore = {
            -- Ignore unlisted buffers. See :help buflisted
            unlisted_buffers = true,

            -- List of filetypes to ignore.
            filetypes = {},

            buftypes = "special",

            wintypes = "special",
        },

        attach_mode = "global",

        -- When you fold code with za, zo, or zc, update the aerial tree as well.
        -- Only works when manage_folds = true
        link_folds_to_tree = false,

        -- Fold code when you open/collapse symbols in the tree.
        -- Only works when manage_folds = true
        link_tree_to_folds = true,

        -- Use symbol tree for folding. Set to true or false to enable/disable
        -- 'auto' will manage folds if your previous foldmethod was 'manual'
        manage_folds = false,

        -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
        -- 'auto' will set it to true if nvim-web-devicons or lspkind-nvim is installed.
        nerd_font = "auto",

        -- Call this function when aerial attaches to a buffer.
        -- Useful for setting keymaps. Takes a single `bufnr` argument.
        on_attach = nil,
        -- function(bufnr)
        --     -- Jump forwards/backwards with '{' and '}'
        --     vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        --     vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        -- end,

        -- Automatically open aerial when entering supported buffers.
        -- This can be a function (see :help aerial-open-automatic)
        open_automatic = false,

        -- Run this command after jumping to a symbol (false will disable)
        post_jump_cmd = "normal! zz",

        -- When true, aerial will automatically close after jumping to a symbol
        close_on_select = false,

        -- Show box drawing characters for the tree hierarchy
        show_guides = true,

        -- The autocmds that trigger symbols update (not used for LSP backend)
        update_events = "TextChanged,InsertLeave",

        -- Customize the characters used when show_guides = true
        guides = {
            -- When the child item has a sibling below it
            mid_item = "├─",
            -- When the child item is the last in the list
            last_item = "╰─",
            -- When there are nested child guides to the right
            nested_top = "│",
            -- Raw indentation
            whitespace = "",
        },

        -- Options for opening aerial in a floating win
        float = {
            -- Controls border appearance. Passed to nvim_open_win
            border = require("config").ui.sidebar_width,

            -- Enum: cursor, editor, win
            relative = "cursor",

            -- These control the height of the floating window.
            max_height = require("config").ui.float_ui_win.height,
            height = nil,
            min_height = { require("config").ui.float_ui_win.height, 0.1 },

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

        -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
        -- Additionally, if it is a string that matches "aerial.<name>",
        -- it will use the mapping at require("aerial.action").<name>
        -- Set to `false` to remove a keymap
        keymaps = {
            ["?"] = "actions.show_help",
            ["g?"] = false,
            ["<CR>"] = "actions.jump",
            ["<2-LeftMouse>"] = "actions.jump",
            ["<C-v>"] = "actions.jump_vsplit",
            ["<C-s>"] = "actions.jump_split",
            ["p"] = "actions.scroll",
            ["<C-j>"] = "actions.down_and_scroll",
            ["<C-k>"] = "actions.up_and_scroll",
            ["["] = "actions.prev",
            ["]"] = "actions.next",
            ["{"] = false,
            ["}"] = false,
            ["q"] = "actions.close",
            ["o"] = "actions.tree_toggle",
            ["za"] = "actions.tree_toggle",
            ["O"] = "actions.tree_toggle_recursive",
            ["zA"] = "actions.tree_toggle_recursive",
            ["l"] = "actions.tree_open",
            -- ["l"] = "actions.select",
            ["zo"] = false,
            ["zO"] = "actions.tree_open_recursive",
            ["h"] = "actions.tree_close",
            ["zc"] = false,
            -- ["H"] = "actions.tree_close_recursive",
            ["zC"] = "actions.tree_close_recursive",
            ["zr"] = "actions.tree_increase_fold_level",
            ["zR"] = "actions.tree_open_all",
            ["zm"] = "actions.tree_decrease_fold_level",
            ["zM"] = "actions.tree_close_all",
            ["zx"] = "actions.tree_sync_folds",
            ["zX"] = "actions.tree_sync_folds",
            ["[["] = false,
            ["]]"] = false,
            ["K"] = "actions.AerialPrev",
        },
    },
    keys = { mode = "n", "<F3>", "<cmd>AerialToggle<cr>", desc = "Open outline" },
}
return _M

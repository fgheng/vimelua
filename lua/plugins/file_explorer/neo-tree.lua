local neo_tree = require("neo-tree")
local icons = require("ui.icons")

----------------------------------------------------------------------
--                            functions                             --
----------------------------------------------------------------------
local chdir_or_open = function(state)
    local node = state.tree:get_node()
    if node.type == "directory" or node:has_children() then
        if state.commands["set_root"] ~= nil then
            vim.notify("set root dir " .. node.path)
            state.commands.set_root(state)
        end
    else
        if state.commands["open"] ~= nil then
            state.commands.open(state)
        else
            vim.notify("open not found")
        end
    end
end

local window_open = function(state)
    local node = state.tree:get_node()
    if node.type == "directory" or node:has_children() then
        if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
            -- neo_tree.ui.focus_node(state, node:get_child_ids()[1])
        end
    else
        state.commands.open_with_window_picker(state)
    end
end

local window_open_close = function(state)
    local node = state.tree:get_node()
    if node.type == "directory" or node:has_children() then
        state.commands.toggle_node(state)
    else
        state.commands.open_with_window_picker(state)
    end
end

local set_root_or_open = function(state)
    local node = state.tree:get_node()
    if node.type == "directory" or node:has_children() then
        state.commands.set_root(state)
    else
        state.commands.open_with_window_picker(state)
    end
end

----------------------------------------------------------------------
--                              config                              --
----------------------------------------------------------------------
neo_tree.setup({
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    source_selector = {
        winbar = true,
        statusline = true,
        sources = { -- table
            {
                source = "filesystem", -- string
                display_name = "   Files ", -- string | nil
            },
            {
                source = "buffers", -- string
                display_name = "  Buffers ", -- string | nil
            },
            {
                source = "git_status", -- string
                display_name = "  Git ", -- string | nil
            },
        },
        content_layout = "start", -- string
        tabs_layout = "equal", -- string
        truncation_character = "…", -- string
        tabs_min_width = nil, -- int | nil
        tabs_max_width = nil, -- int | nil
        padding = 0, -- int | { left: int, right: int }
        separator = { left = "▏", right = "▕" }, -- string | { left: string, right: string, override: string | nil }
        separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
        show_separator_on_edge = false, -- boolean
        highlight_tab = "NeoTreeTabInactive", -- string
        highlight_tab_active = "NeoTreeTabActive", -- string
        highlight_background = "NeoTreeTabInactive", -- string
        highlight_separator = "NeoTreeTabSeparatorInactive", -- string
        highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
    },
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly
    default_component_configs = {
        container = {
            enable_character_fade = true,
        },
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = icons.collapsed,
            expander_expanded = icons.expanded,
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = icons.folder,
            folder_open = icons.folder_open,
            folder_empty = icons.folder_empty,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
        },
        modified = {
            symbol = icons.flash .. " ",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = icons.git_add .. " ", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = icons.git_modified .. " ", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted = icons.git_deleted .. " ", -- this can only be used in the git_status source
                renamed = icons.git_rename .. " ",
                -- Status type
                untracked = icons.git_untracked .. " ",
                ignored = icons.git_ignore .. " ",
                unstaged = icons.git_unstaged .. " ",
                staged = icons.git_staged .. " ",
                conflict = icons.git_confict .. " ",
            },
        },
    },
    -- A list of functions, each representing a global custom command
    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
    -- see `:h neo-tree-global-custom-commands`
    commands = {},

    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<2-LeftMouse>"] = "open",
            ["l"] = window_open,
            ["o"] = window_open_close,
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["<c-s>"] = "open_split",
            ["<c-v>"] = "open_vsplit",
            ["<c-t>"] = "open_tabnew",
            ["h"] = "close_node",
            ["H"] = "close_all_subnodes",
            ["z"] = false,
            ["L"] = "expand_all_nodes",
            ["a"] = {
                "add",
                config = {
                    show_path = "relative", -- "none", "relative", "absolute"
                },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<M-h>"] = "prev_source",
            ["<M-l>"] = "next_source",
        },
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                ".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
                ".null-ls_*",
            },
        },
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
            mappings = {
                ["<cr>"] = set_root_or_open,
                ["."] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                -- ["D"] = "fuzzy_sorter_directory",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["gk"] = "prev_git_modified",
                ["gj"] = "next_git_modified",
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                ["<down>"] = "move_cursor_down",
                ["<C-j>"] = "move_cursor_down",
                ["<up>"] = "move_cursor_up",
                ["<C-k>"] = "move_cursor_up",
            },
        },

        commands = {}, -- Add a custom command or override a global one using the same function name
    },
    buffers = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
            mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
            },
        },
    },
    git_status = {
        window = {
            position = "float",
            mappings = {
                ["A"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            },
        },
    },
})

----------------------------------------------------------------------
--                              keymap                              --
----------------------------------------------------------------------
local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<F2>", "<cmd>NeoTreeRevealToggle<cr>", opts)
vim.keymap.set("n", "<leader>ee", function()
    vim.api.nvim_command("Neotree left")
    -- vim.ui.input({ prompt = "NeoTree", default = "" }, function(input)
    --     if input ~= nil then
    --         vim.api.nvim_command("Neotree " .. input)
    --     end
    -- end)
end, opts)
vim.keymap.set("n", "<leader>er", function()
    vim.api.nvim_command("Neotree right")
end, opts)
vim.keymap.set("n", "<leader>ef", function()
    vim.api.nvim_command("Neotree float")
end, opts)

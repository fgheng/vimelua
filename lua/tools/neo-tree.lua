-- local chdir_or_open = function(state)
--     local node = state.tree:get_node()
--     if node.type == "directory" or node:has_children() then
--         if state.commands["set_root"] ~= nil then
--             vim.notify("set root dir " .. node.path)
--             state.commands.set_root(state)
--         end
--     else
--         if state.commands["open"] ~= nil then
--             state.commands.open(state)
--         else
--             vim.notify("open not found")
--         end
--     end
-- end

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

local _M = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "echasnovski/mini.icons",
        "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree", "NeoTreeShow", "NeoTreeClose" },
    config = function()
        require("neo-tree").setup({
            auto_clean_after_session_restore = true,
            close_if_last_window = false,
            popup_border_style = require("config").ui.float_ui_win.border,
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
            open_files_using_relative_paths = false,
            sort_case_insensitive = false, -- used when sorting files and directories in the tree
            sort_function = nil, -- use a custom function for sorting files and directories in the tree

            source_selector = {
                winbar = true,
                statusline = false,
                sources = { -- table
                    {
                        source = "filesystem", -- string
                        display_name = "  Files ", -- string | nil
                    },
                    {
                        source = "buffers", -- string
                        display_name = " Buffers ", -- string | nil
                    },
                    {
                        source = "git_status", -- string
                        display_name = " Git ", -- string | nil
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
                highlight_tab = "None", -- string
                highlight_tab_active = "@annotation", -- string
                highlight_background = "NeoTreeTabInactive", -- string
                highlight_separator = "None", -- string
                highlight_separator_active = "None", -- string
            },
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
                    last_indent_marker = "╰", --└
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = require("utils.icons").symbols.folder_close,
                    expander_expanded = require("utils.icons").symbols.folder_open,
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = require("utils.icons").symbols.folder_close,
                    folder_open = require("utils.icons").symbols.folder_open,
                    folder_empty = require("utils.icons").symbols.folder_empty,
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon",
                },
                modified = {
                    symbol = require("utils.icons").git.modify .. " ",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
                git_status = {
                    symbols = {
                        -- -- Change type
                        added = require("utils.icons").git.add .. " ",
                        modified = require("utils.icons").git.modify .. " ",
                        deleted = require("utils.icons").git.delete .. " ",
                        renamed = require("utils.icons").git.rename .. " ",
                        untracked = require("utils.icons").git.untrack .. " ",
                        ignored = require("utils.icons").git.ignore .. " ",
                        unstaged = require("utils.icons").git.unstage .. " ",
                        staged = require("utils.icons").git.stage .. " ",
                        conflict = require("utils.icons").git.confict .. " ",
                    },
                },

                file_size = {
                    enabled = false,
                    width = 12, -- width of the column
                    required_width = 64, -- min width of window required to show this column
                },
                type = {
                    enabled = false,
                    width = 10, -- width of the column
                    required_width = 122, -- min width of window required to show this column
                },
                last_modified = {
                    enabled = false,
                    width = 20, -- width of the column
                    required_width = 88, -- min width of window required to show this column
                },
                created = {
                    enabled = false,
                    width = 20, -- width of the column
                    required_width = 110, -- min width of window required to show this column
                },
                symlink_target = {
                    enabled = true,
                },
            },

            window = {
                position = "left",
                width = require("config").ui.sidebar_width,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<2-LeftMouse>"] = "open",
                    -- ["H"] = "close_all_subnodes",
                    ["H"] = false,
                    ["l"] = window_open,
                    ["o"] = window_open_close,
                    ["<esc>"] = "revert_preview",
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["<c-s>"] = "open_split",
                    ["<c-v>"] = "open_vsplit",
                    ["<c-t>"] = "open_tabnew",
                    ["h"] = "close_node",
                    ["zC"] = "close_all_subnodes",
                    ["zO"] = "expand_all_nodes",
                    ["z"] = false,
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
                    ["c"] = {
                        "copy",
                        config = {
                            show_path = "absolute", -- "none", "relative", "absolute"
                        },
                    },
                    ["m"] = {
                        "move",
                        config = {
                            show_path = "absolute", -- "none", "relative", "absolute"
                        }
                    }, -- takes text input for destination, also accepts the optional config.show_path option like "add".
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<M-h>"] = "prev_source",
                    ["<M-l>"] = "next_source",

                    ["K"] = "show_file_details",
                    ["i"] = false,
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
                -- time the current file is changed while the tree is open.
                group_empty_dirs = false, -- when true, empty folders will be grouped together
                hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                -- instead of relying on nvim autocmd events.
                window = {
                    mappings = {
                        ["<cr>"] = set_root_or_open,
                        ["."] = "toggle_hidden",
                        ["gk"] = "prev_git_modified",
                        ["gj"] = "next_git_modified",
                        -- ["/"] = "fuzzy_finder",
                        ["/"] = false,
                        -- ["D"] = "fuzzy_finder_directory",
                        ["D"] = false,
                        -- ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                        ["#"] = false, -- fuzzy sorting using the fzy algorithm
                        -- ["D"] = "fuzzy_sorter_directory",
                        -- ["f"] = "filter_on_submit",
                        ["f"] = false,
                        -- ["<c-x>"] = "clear_filter",
                        ["<c-x>"] = false,
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
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                }, -- This will find and focus the file in the active buffer every
                -- follow_current_file = true, -- This will find and focus the file in the active buffer every
                -- time the current file is changed while the tree is open.
                group_empty_dirs = true, -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["?"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                    },
                },
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["gA"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                        ["?"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "g" } },
                    },
                },
            },

            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        -- vim.o.showmode = false
                        -- vim.o.ruler = false
                        -- vim.o.laststatus = 0
                        -- vim.o.showcmd = false
                        vim.wo.statusline = nil
                    end,
                },
                {
                    event = "neo_tree_buffer_leave",
                    handler = function()
                        -- vim.o.showmode = true
                        -- vim.o.ruler = true
                        -- vim.o.laststatus = 3
                        -- vim.o.showcmd = true
                    end,
                },
            },
        })
    end,
    keys = {
        { mode = "n", "<F2>", "<cmd>NeoTreeRevealToggle<cr>", desc = "Toggle NeoTree" },
        { mode = "n", "<leader>ee", "<cmd>Neotree left<cr>", desc = "NeoTree left" },
        { mode = "n", "<leader>er", "<cmd>Neotree right<cr>", desc = "NeoTree right" },
        { mode = "n", "<leader>ef", "<cmd>Neotree float<cr>", desc = "NeoTree float" },
    },
}
return _M

local _M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "tsakirist/telescope-lazy.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
    cmd = { "Telescope" },
    event = { "BufNewFile" },
    config = function()
        local telescope = require("telescope")
        local icons = require("utils.icons")

        telescope.setup({
            hide_numbers = true,
            defaults = {
                mappings = {
                    i = {
                        ["<c-j>"] = "move_selection_next",
                        ["<c-k>"] = "move_selection_previous",
                        ["<M-j>"] = "move_selection_next",
                        ["<M-k>"] = "move_selection_previous",
                        ["<M-d>"] = "preview_scrolling_down",
                        ["<M-u>"] = "preview_scrolling_up",
                        ["<c-v>"] = "select_vertical",
                        ["<c-s>"] = "select_horizontal",
                        ["<c-t>"] = "select_tab",
                        ["<c-/>"] = "which_key",
                    },
                    n = {
                        ["<c-j>"] = "move_selection_next",
                        ["<c-k>"] = "move_selection_previous",
                        ["<M-j>"] = "move_selection_next",
                        ["<M-k>"] = "move_selection_previous",
                        ["<c-v>"] = "select_vertical",
                        ["<c-s>"] = "select_horizontal",
                        ["<c-t>"] = "select_tab",
                        ["l"] = "select_default",
                        ["?"] = "which_key",
                    },
                },

                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--glob",
                    "!.git/*",
                    "--trim", -- add this value
                },

                prompt_prefix = icons.icons.telescope .. "  ",
                selection_caret = icons.icons.double_arrow_right .. "  ",
                path_display = {
                    "absolute",
                },
                file_ignore_patterns = { "node_modules" },
                -- layout_strategy = "vertical",
                layout_strategy = "bottom_pane",
                layout_config = {
                    -- anchor = "N",
                    height = 0.3,
                    -- width = { 0.4, max = 100, min = 60 },
                    mirror = false,
                    prompt_position = "top",
                },
                sorting_strategy = "ascending",
                -- themes = 'ivy',
                winblend = 0,
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
                symbols = {
                    sources = { "emoji", "kaomoji", "gitmoji" },
                },
                jumplist = {
                    show_line = false,
                    trim_text = false,
                    fname_width = 10,
                },
                lsp_references = {
                    include_declaration = true,
                    include_current_line = false,
                    fname_width = 10,
                    show_line = false,
                    trim_text = false,
                },
                lsp_definitions = {
                    show_line = true,
                    trim_text = true,
                },
                diagnostic = {
                    bufnr = 0, -- current buffer or nil for all buffers
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                live_grep_args = {
                    auto_quoting = false, -- enable/disable auto-quoting
                    -- override default mappings
                    default_mappings = {},
                    mappings = { -- extend mappings
                        i = {
                            ["<C-p>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                            ["<C-l>"] = require("telescope-live-grep-args.actions").quote_prompt({
                                postfix = " --iglob ",
                            }),
                            ["<C-t>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t " }),
                        },
                    },
                },
                -- repo = {
                --     list = {
                --         fd_opts = {
                --             "--no-ignore-vcs",
                --         },
                --         search_dirs = {
                --             "~/workspace",
                --         },
                --     },
                -- },
                -- file_browser = {
                --     -- theme = 'ivy',
                --     -- disables netrw and use telescope-file-browser in its place
                --     hijack_netrw = true,
                -- },
            },
        })

        telescope.load_extension("ui-select")
        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
        telescope.load_extension("lazy")
        -- telescope.load_extension("repo")
        -- telescope.load_extension("file_browser")

        ----------------------------------------------------------------------
        --                               fzf                                --
        ----------------------------------------------------------------------
        -- Token 	Match type 	Description
        -- sbtrkt 	fuzzy-match 	Items that match sbtrkt
        -- 'wild 	exact-match (quoted) 	Items that include wild
        -- ^music 	prefix-exact-match 	Items that start with music
        -- .mp3$ 	suffix-exact-match 	Items that end with .mp3
        -- !fire 	inverse-exact-match 	Items that do not include fire
        -- !^music 	inverse-prefix-exact-match 	Items that do not start with music
        -- !.mp3$ 	inverse-suffix-exact-match 	Items that do not end with .mp3

        ----------------------------------------------------------------------
        --                                rg                                --
        ----------------------------------------------------------------------
        -- foo bar	foo bar	search for „foo bar“
        -- "foo bar" baz	foo bar, baz	search for „foo bar“ in dir „baz“
        -- --no-ignore "foo bar	--no-ignore, foo bar	search for „foo bar“ ignoring ignores
        -- "foo" --iglob **/test/**	search for „foo“ in any „test“ path
        -- "foo" ../other-project	foo, ../other-project	search for „foo“ in ../other-project
    end,
    keys = {
        {
            mode = "n",
            "<space><space>",
            function()
                if vim.bo.filetype ~= "qf" then
                    vim.api.nvim_command("Telescope")
                else
                    vim.api.nvim_command("normal! <CR>")
                end
            end,
            desc = "Open Telescope",
        },
        { mode = "n", "<space>f", "<cmd>Telescope find_files<cr>", desc = "Telescope finde files" },
        { mode = "n", "<space>c", "<cmd>Telescope commands<cr>", desc = "Telescope show all commands" },
        {
            mode = "n",
            "<space>s",
            "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({})<cr>",
            desc = "Telescope search",
        },
        {
            mode = "v",
            "<space>s",
            function()
                local selected_text = require("utils.utils").get_visual_selection()
                selected_text = string.gsub(selected_text, "\n", "")
                require("telescope").extensions.live_grep_args.live_grep_args({ default_text = selected_text })
            end,
            desc = "Telescope search",
        },
        { mode = "n", "<space>g" },
        { mode = "n", "<space>b", "<cmd>Telescope buffers<cr>" },
        { mode = "n", "<space>a" },
        { mode = "n", "<space>r", "<cmd>Telescope oldfiles<cr>" },
        { mode = "n", "<space>j", "<cmd>Telescope jumplist<cr>" },
        { mode = "n", "<space>o", "<cmd>Telescope lsp_document_symbols<cr>" },
        {
            mode = "v",
            "<space>o",
            function()
                local selected_text = require("utils.utils").getvisualselection()
                selected_text = string.gsub(selected_text, "\n", "")
                require("telescope.builtin").lsp_document_symbols({ default_text = selected_text })
            end,
        },
        { mode = "n", "<space>O", "<cmd>Telescope lsp_workspace_symbols<cr>" },
        {
            mode = "v",
            "<space>O",
            function()
                local selected_text = require("utils.utils").getvisualselection()
                selected_text = string.gsub(selected_text, "\n", "")
                require("telescope.builtin").lsp_workspace_symbols({ default_text = selected_text })
            end,
        },
        {
            mode = "n",
            "<space>/",
            function()
                local current_buffer = vim.api.nvim_get_current_buf()
                local abs_path = vim.api.nvim_buf_get_name(current_buffer)
                require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = { abs_path } })
            end,
        },
        {
            mode = "v",
            "<space>/",
            function()
                local selected_text = require("utils.utils").get_visual_selection()
                selected_text = string.gsub(selected_text, "\n", "")
                local current_buffer = vim.api.nvim_get_current_buf()
                local abs_path = vim.api.nvim_buf_get_name(current_buffer)
                require("telescope").extensions.live_grep_args.live_grep_args({
                    search_dirs = { abs_path },
                    default_text = selected_text,
                })
                -- tb.current_buffer_fuzzy_find({ default_text = selected_text })
            end,
        },
        { mode = "n", "<space>?", "<cmd>Telescope diagnostics<cr>" },
        {
            mode = "v",
            "<space>?",
            function()
                local selected_text = require("utils.utils").get_visual_selection()
                selected_text = string.gsub(selected_text, "\n", "")
                require("telescope.builtin").diagnostics({ default_text = selected_text })
            end,
        },
        -- {
        --     mode = "n",
        --     "<space>zs",
        --     function()
        --         require("telescope").extensions.live_grep_args.live_grep_args({
        --             search_dirs = { require("config").notes_home },
        --             path_display = { "tail" },
        --         })
        --     end,
        -- },
        -- {
        --     mode = "v",
        --     "<space>zs",
        --     function()
        --         local selected_text = require("utils.utils").get_visual_selection()
        --         selected_text = string.gsub(selected_text, "\n", "")
        --         require("telescope").extensions.live_grep_args.live_grep_args({
        --             search_dirs = { require("config").notes_home },
        --             default_text = selected_text,
        --             path_display = { "tail" },
        --         })
        --     end,
        -- },
        -- {
        --     mode = "n",
        --     "<space>zt",
        --     function()
        --         -- require("telescope").extensions.live_grep_args.live_grep_args({
        --         --     search_dirs = { require("config").notes_home },
        --         --     default_text = "(^|\\s)#[A-Za-z\\u4e00-\\u9fff0-9_]+$",
        --         --     path_display = { "hidden" },
        --         -- })
        --         local pickers = require("telescope.pickers")
        --         local finders = require("telescope.finders")
        --         local conf = require("telescope.config").values
        --         local actions = require("telescope.actions")
        --         local action_state = require("telescope.actions.state")
        --         local action_utils = require("telescope.actions.utils")
        --         local entry_display = require("telescope.pickers.entry_display")
        --         local previewers = require("telescope.previewers")
        --
        --         local options = {}
        --         local telescope_options = vim.tbl_extend("force", { prompt_title = "tags" }, {})
        --
        --         local client_id = require("utils.utils").get_lsp_client_by_name("zk")
        --         if not client_id then
        --             print("client id " .. client_id)
        --             return
        --         end
        --         local lsp_client = vim.lsp.get_client_by_id(client_id)
        --         if lsp_client == nil then
        --             print("lsp client is nil")
        --             return
        --         end
        --
        --         local tags = {}
        --
        --         lsp_client.request("workspace/executeCommand", {
        --             command = "zk.tag.list",
        --             arguments = {
        --                 require("config").notes_home,
        --                 nil,
        --             },
        --         }, function(_, all_tags)
        --             print(vim.inspect(all_tags))
        --             tags = all_tags
        --
        --         pickers
        --             .new(telescope_options, {
        --                 finder = finders.new_table({
        --                     results = all_tags,
        --                     entry_maker = function(tag)
        --                         print(tag.name)
        --                         local displayer = entry_display.create({
        --                             separator = " ",
        --                             items = {
        --                                 { width = 4 },
        --                                 { remaining = true },
        --                             },
        --                         })
        --                         local make_display = function(e)
        --                             return displayer({
        --                                 { e.value.note_count, "TelescopeResultsNumber" },
        --                                 e.value.name,
        --                             })
        --                         end
        --                         return {
        --                             value = tag,
        --                             display = make_display,
        --                             ordinal = tag.name,
        --                         }
        --                     end,
        --                 }),
        --                 -- attach_mappings = function(prompt_bufnr, _)
        --                 --     actions.select_default:replace(function()
        --                 --         if options.multi_select then
        --                 --             local selection = {}
        --                 --             action_utils.map_selections(prompt_bufnr, function(entry, _)
        --                 --                 table.insert(selection, entry.value)
        --                 --             end)
        --                 --             if vim.tbl_isempty(selection) then
        --                 --                 selection = { action_state.get_selected_entry().value }
        --                 --             end
        --                 --             actions.close(prompt_bufnr)
        --                 --             cb(selection)
        --                 --         else
        --                 --             cb(action_state.get_selected_entry().value)
        --                 --         end
        --                 --     end)
        --                 --     return true
        --                 -- end,
        --             })
        --             :find()
        --         end, vim.api.nvim_get_current_buf())
        --         print(vim.inspect(tags))
        --     end,
        -- },
        -- {
        --     mode = "n",
        --     "<space>zl",
        --     function()
        --         require("telescope.builtin").find_files({
        --             search_dirs = { require("config").notes_home },
        --             path_display = { "tail" },
        --         })
        --     end,
        -- },
    },
}

return _M

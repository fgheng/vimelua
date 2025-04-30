local _M = {
    "nvim-telescope/telescope.nvim",
    enabled = function()
        return require("config").picker == "telescope"
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        { "nvim-telescope/telescope-live-grep-args.nvim" }, -- usage: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
        { "nvim-telescope/telescope-symbols.nvim" },
        { "tsakirist/telescope-lazy.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        -- { "nvim-telescope/telescope-frecency.nvim" },
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
                        ["<M-J>"] = "preview_scrolling_down",
                        ["<M-K>"] = "preview_scrolling_up",
                        ["<M-L>"] = "preview_scrolling_right",
                        ["<M-H>"] = "preview_scrolling_left",
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
                selection_caret = icons.symbols.select_arrow .. "  ",
                path_display = {
                    "absolute",
                },
                file_ignore_patterns = { "node_modules", ".git" },
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
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
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
            "<space>g",
            function()
                vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
                    require("telescope").lsp_workspace_symbols({ query = query })
                end)
            end,
        },
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
        {
            mode = "n",
            "<space>f",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Telescope finde files",
        },
        {
            mode = "n",
            "<space>c",
            function()
                require("telescope.builtin").commands()
            end,
            desc = "Telescope show all commands",
        },
        {
            mode = "n",
            "<space>s",
            function()
                require("telescope").extensions.live_grep_args.live_grep_args({ additional_args = { "-j1" } })
            end,
            desc = "Telescope search",
        },
        {
            mode = "v",
            "<space>s",
            function()
                local selected_text = require("utils.utils").get_visual_selection()
                selected_text = string.gsub(selected_text, "\n", "")
                require("telescope").extensions.live_grep_args.live_grep_args({
                    default_text = selected_text,
                    additional_args = { "-j1" },
                })
            end,
            desc = "Telescope search",
        },
        { mode = "n", "<space>b", "<cmd>Telescope buffers<cr>" },
        -- { mode = "n", "<tab><tab>", "<cmd>Telescope buffers<cr>" },
        { mode = "n", "<space>r", "<cmd>Telescope oldfiles<cr>" },
        { mode = "n", "<space>j", "<cmd>Telescope jumplist<cr>" },
        {
            mode = "n",
            "<space>/",
            function()
                local current_buffer = vim.api.nvim_get_current_buf()
                local abs_path = vim.api.nvim_buf_get_name(current_buffer)
                require("telescope").extensions.live_grep_args.live_grep_args({
                    search_dirs = { abs_path },
                    path_display = { "hidden" },
                })
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
                    path_display = { "hidden" },
                })
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
    },
}

return _M

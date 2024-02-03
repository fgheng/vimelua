-- local status_ok, telescope = pcall(require, "telescope")
-- if not status_ok then
--     vim.notify("telescope not found")
--     return
-- end

local telescope = require("telescope")
-- local actions_state = require("telescope.actions.state")
local icons = require("ui.icons")

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

        prompt_prefix = " " .. icons.search .. "  ",
        selection_caret = icons.arrow_right .. "  ",
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
            show_line = false,
            trim_text = false,
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
                    ["<C-l>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
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

telescope.load_extension("ui-select") -- using dressing
telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
telescope.load_extension("lazy")
-- telescope.load_extension("repo")
-- telescope.load_extension("file_browser")

local tb = require("telescope.builtin")
local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
-- keymap('n', '<space><space>', '<cmd>Telescope<cr>', opts)
-- keymap('n', '<CR>', '<cmd>Telescope<cr>', opts)
vim.keymap.set("n", "<space><space>", function()
    if vim.bo.filetype ~= "qf" then
        vim.api.nvim_command("Telescope")
    else
        vim.api.nvim_command("normal! <CR>")
    end
end, opts)
keymap("n", "<space>f", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<space>s", function()
    require("telescope").extensions.live_grep_args.live_grep_args({})
end, opts)
vim.keymap.set("v", "<space>s", function()
    local selected_text = require("utils").getVisualSelection()
    selected_text = string.gsub(selected_text, "\n", "")
    require("telescope").extensions.live_grep_args.live_grep_args({ default_text = selected_text })
end, opts)
vim.keymap.set("n", "<space>/", function()
    local current_buffer = vim.api.nvim_get_current_buf()
    local abs_path = vim.api.nvim_buf_get_name(current_buffer)
    require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = { abs_path } })
end, opts)
vim.keymap.set("v", "<space>/", function()
    local selected_text = require("utils").getVisualSelection()
    selected_text = string.gsub(selected_text, "\n", "")
    local current_buffer = vim.api.nvim_get_current_buf()
    local abs_path = vim.api.nvim_buf_get_name(current_buffer)
    require("telescope").extensions.live_grep_args.live_grep_args({
        search_dirs = { abs_path },
        default_text = selected_text,
    })
    -- tb.current_buffer_fuzzy_find({ default_text = selected_text })
end, opts)
keymap("n", "<space>b", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<space>?", "<cmd>Telescope diagnostics<cr>", opts)
vim.keymap.set("v", "<space>?", function()
    local selected_text = require("utils").getVisualSelection()
    selected_text = string.gsub(selected_text, "\n", "")
    tb.diagnostics({ default_text = selected_text })
end, opts)
keymap("n", "<space>r", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<space>j", "<cmd>Telescope jumplist<cr>", opts)
keymap("n", "<space>o", "<cmd>Telescope lsp_document_symbols<cr>", opts)
vim.keymap.set("v", "<space>o", function()
    local selected_text = require("utils").getvisualselection()
    selected_text = string.gsub(selected_text, "\n", "")
    tb.lsp_document_symbols({ default_text = selected_text })
end, opts)
keymap("n", "<space>O", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
vim.keymap.set("v", "<space>O", function()
    local selected_text = require("utils").getvisualselection()
    selected_text = string.gsub(selected_text, "\n", "")
    tb.lsp_workspace_symbols({ default_text = selected_text })
end, opts)
vim.keymap.set("n", "<space>zs", function()
    require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = { require("config").notes_home } })
end, opts)
vim.keymap.set("v", "<space>zs", function()
    local selected_text = require("utils").getVisualSelection()
    selected_text = string.gsub(selected_text, "\n", "")
    require("telescope").extensions.live_grep_args.live_grep_args({
        search_dirs = { require("config").notes_home },
        default_text = selected_text,
    })
end, opts)
-- vim.keymap.set("n", "<space>e", "<cmd>Telescope file_browser<CR>", opts)

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

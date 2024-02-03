local gitsigns = require("gitsigns")
local icons = require("ui.icons")

gitsigns.setup({
    signs = {
        add = {
            hl = "GitSignsAdd",
            text = icons.line_bold,
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
        },
        change = {
            hl = "GitSignsChange",
            text = icons.line_bold,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
        delete = {
            hl = "GitSignsDelete",
            text = icons.line_bold,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = icons.line_bold,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        changedelete = {
            hl = "GitSignsChange",
            text = icons.line_bold,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
    },

    -- signs = {
    --     add = { text = "│" },
    --     change = { text = "│" },
    --     delete = { text = "_" },
    --     topdelete = { text = "‾" },
    --     changedelete = { text = "~" },
    --     untracked = { text = "┆" },
    -- },

    current_line_blame = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    signcolumn = true,
    attach_to_untracked = true,

    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },

    current_line_blame_formatter_opts = {
        relative_time = false,
    },

    max_file_length = 10000,

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "gj", function()
            if vim.wo.diff then
                return "gj"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        map("n", "gk", function()
            if vim.wo.diff then
                return "gk"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "gsh", gs.stage_hunk)
        map("n", "gsu", gs.undo_stage_hunk)
        map("n", "gsb", gs.stage_buffer)

        map({ "n", "v" }, "gu", gs.reset_hunk)
        map("n", "gU", gs.reset_buffer)
        map("n", "gp", gs.preview_hunk)
        -- map("n", "gb", gs.blame_line)
        map("n", "gb", gs.toggle_current_line_blame)
        map("n", "gtw", "<cmd>Gitsigns toggle_word_diff<CR>")
        map("n", "gtl", "<cmd>Gitsigns toggle_linehl<CR>")
        map("n", "gtd", "<cmd>Gitsigns toggle_deleted<cr>")

        -- map("n", "gd", function()
        --     vim.ui.input({ prompt = "diff against: ", default = "~" }, function(input)
        --         if input ~= nil then
        --             gs.diffthis({ rev = input })
        --         end
        --     end)
        -- end)

        -- Text object
        -- map({ "o", "x" }, "gv", "<cmd>Gitsigns select_hunk<CR>")
        map({ "n", "v" }, "gss", "<cmd>Gitsigns select_hunk<CR>")
    end,
})

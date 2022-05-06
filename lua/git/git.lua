local _M = {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")
            local icons = require("utils.icons")

            gitsigns.setup({
                signs = {
                    add = {
                        hl = "GitSignsAdd",
                        text = icons.icons.vertical_bar,
                        numhl = "GitSignsAddNr",
                        linehl = "GitSignsAddLn",
                    },
                    change = {
                        hl = "GitSignsChange",
                        text = icons.icons.vertical_bar,
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        text = icons.icons.vertical_bar,
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = icons.icons.vertical_bar,
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = icons.icons.vertical_bar,
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },

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

                    -- Text object
                    -- map({ "o", "x" }, "gv", "<cmd>Gitsigns select_hunk<CR>")
                    map({ "n", "v" }, "gss", "<cmd>Gitsigns select_hunk<CR>")
                end,
            })
        end,
        cmd = { "Gitsigns" },
        event = { "BufRead" },
    },
    {
        "sindrets/diffview.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-tree/nvim-web-devicons" },
        },
        cmd = {
            "DiffviewOpen",
            "DiffviewLog",
            "DiffviewFileHistory",
        },
        opts = {
            use_icons = false,
        },
        keys = {
            {
                mode = "n",
                "<leader>gd",
                function()
                    vim.ui.input({ prompt = "commit: ", default = "" }, function(input)
                        if input ~= nil then
                            vim.api.nvim_command("DiffviewOpen " .. input)
                        end
                    end)
                end,
                desc = "Open diff view",
            },
            { mode = "n", "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
            { mode = "n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Open file history" },
        },
    },
}

return _M

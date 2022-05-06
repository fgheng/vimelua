vim.defer_fn(function()
    local opts = { noremap = true, silent = true }
    local api = vim.api

    local keymaps = {
        normal = {
            ["<c-h>"] = "<c-w>h",
            ["<c-j>"] = "<c-w>j",
            ["<c-k>"] = "<c-w>k",
            ["<c-l>"] = "<c-w>l",

            ["<c-w>k"] = "<cmd>abo split<cr>",
            ["<c-w>h"] = "<cmd>abo vsplit<cr>",
            ["<c-w>j"] = "<cmd>rightbelow split<cr>",
            ["<c-w>l"] = "<cmd>rightbelow vsplit<cr>",
            ["<c-=>"] = "<c-w>=",

            ["Q"] = "q",
            ["q"] = "<cmd>close<cr>",

            ["<m-L>"] = "<cmd>tabnext<cr>",
            ["<m-H>"] = "<cmd>tabpre<cr>",
            ["<leader>tn"] = "<cmd>tabnew<cr>",

            ["<BackSpace>"] = "<cmd>nohl<cr>",

            [">>"] = ">>_",
            ["<<"] = "<<_",

            ["j"] = "gj",
            ["k"] = "gk",

            -- ["<leader>tt"] = "<cmd>terminal<cr>",
            -- ["<c-w>o"] = "<c-w>_<c-w>|"
        },

        visual = {
            ["j"] = "gj",
            ["k"] = "gk",
        },

        insert = {
            ["<m-o>"] = "<esc>o",
            ["<m-O>"] = "<esc>O",
            ["<m-a>"] = "<End>",
            ["<m-i>"] = "<esc>^i",
            ["<SPACE>"] = "<SPACE><C-g>u",
            ["jk"] = "<esc>",
        },

        command = {},

        terminal = {
            -- ["<c-h>"] = "<c-\\><c-n><c-w>h",
            -- ["<c-j>"] = "<c-\\><c-n><c-w>j",
            -- ["<c-k>"] = "<c-\\><c-n><c-w>k",
            -- ["<c-l>"] = "<c-\\><c-n><c-w>l,",

            ["<C-h>"] = "<Cmd>wincmd h<CR>",
            ["<C-j>"] = "<Cmd>wincmd j<CR>",
            ["<C-k>"] = "<Cmd>wincmd k<CR>",
            ["<C-l>"] = "<Cmd>wincmd l<CR>",

            ["jk"] = "<c-\\><c-n>",
            ["<esc>"] = "<c-\\><c-n>",
        },

        operate = {},
    }

    local mode_map = {
        normal = "n",
        visual = "v",
        insert = "i",
        operate = "o",
        command = "c",
        terminal = "t",
    }

    for mode, mode_tbl in pairs(keymaps) do
        for lhs, rhs in pairs(mode_tbl) do
            api.nvim_set_keymap(mode_map[mode], lhs, rhs, opts)
        end
    end

    -- vim.keymap.set("n", "<leader>t", function()
    --     local config = {
    --         relative = "cursor",
    --         row = 10,
    --         col = 10,
    --         width = 40,
    --         height = 10,
    --         style = "minimal",
    --         border = require("config").ui.border,
    --     }
    --
    --     local buf = vim.api.nvim_create_buf(false, true)
    --     vim.api.nvim_buf_set_name(buf, require("config").notes_home .. "/note.md")
    --     -- vim.api.nvim_set_option_value("buftype", "markdown", { scope = "local", buf = buf })
    --     -- vim.api.nvim_set_option_value("filetype", "markdown", { scope = "local", buf = buf })
    --
    --     local win = vim.api.nvim_open_win(buf, true, config)
    -- end, { noremap = true, silent = true })
end, 10)

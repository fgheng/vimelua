vim.defer_fn(function()
    local opts = { noremap = true, silent = true }
    local api = vim.api

    ----------------------------------------------------------------------
    --                          common keymaps                          --
    ----------------------------------------------------------------------
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

            -- ["<TAB>"] = "<C-w><C-w>", -- ctrl-i会有问题
            -- ["<S-TAB>"] = "<C-w>p",

            ["<leader>tt"] = "<cmd>terminal<cr>",
            ["<leader>bo"] = "<cmd>%bd|e#<cr>", -- close all buffers but the current one
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
            ["<C-c>"] = "<C-r>=",
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

    ----------------------------------------------------------------------
    --                         function keymaps                         --
    ----------------------------------------------------------------------
    -- local function_keymaps = {
    --     ["q"] = function()
    --         local M = {}
    --         if vim.fn.tabpagenr("$") == 1 and vim.fn.winnr("$") == 1 then
    --             api.nvim_set_option_value("laststatus", 0, {})
    --
    --             api.nvim_command("enew")
    --             vim.fn.termopen("vifm --choose-files /tmp/nvim-vifm", {
    --                 on_exit = function()
    --                     if M.action ~= nil then
    --                         api.nvim_set_option_value("laststatus", 3, {})
    --                         for line in io.lines("/tmp/nvim-vifm") do
    --                             -- if M.action == "tabnew " and api.nvim_buf_get_name(0):match("term://.*vifm") then
    --                             if api.nvim_buf_get_name(0):match("term://.*vifm") then
    --                                 api.nvim_command("edit " .. line)
    --                             else
    --                                 api.nvim_command(M.action .. line)
    --                             end
    --                         end
    --
    --                         vim.loop.new_thread(function()
    --                             os.remove("/tmp/nvim-vifm")
    --                         end)
    --                     else
    --                         api.nvim_command("silent quitall!")
    --                     end
    --                 end,
    --             })
    --
    --             api.nvim_command("startinsert")
    --
    --             local vifm_action = {
    --                 ["<C-v>"] = function()
    --                     M.action = "vsp"
    --                     return "l"
    --                 end,
    --                 ["<C-s>"] = function()
    --                     M.action = "sp"
    --                     return "l"
    --                 end,
    --                 ["l"] = function()
    --                     M.action = "tabnew "
    --                     return "l"
    --                 end,
    --                 ["<ESC>"] = function()
    --                     return "<ESC>"
    --                 end,
    --             }
    --
    --             for lhs, rhs in pairs(vifm_action) do
    --                 vim.keymap.set("t", lhs, rhs, { buffer = true, expr = true })
    --             end
    --
    --             api.nvim_set_option_value("number", false, { buf = 0 })
    --         else
    --             pcall(api.nvim_command, "quit!")
    --         end
    --     end,
    -- }
    --
    -- for lhs, rhs in pairs(function_keymaps) do
    --     vim.keymap.set("n", lhs, rhs, opts)
    -- end
end, 10)

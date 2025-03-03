return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons" },
        config = function()
            local border = require("config").ui.float_ui_win.border
            local actions = require("fzf-lua").actions
            require("fzf-lua").setup({
                winopts = {
                    split      = "aboveleft new",
                    border     = border,
                    height     = 0.2,
                    width      = 0.8,
                    row        = 0.2,
                    col        = 0.1,
                    backdrop   = 0,
                    preview    = {
                        -- border = border
                        vertical   = "down:50%", -- up|down:size
                        horizontal = "right:50%", -- right|left:size
                    }
                },
                -- on_create = function()
                --     -- called once upon creation of the fzf main window
                --     -- can be used to add custom fzf-lua mappings, e.g:
                --     -- vim.keymap.set("t", "<M-j>", "<Down>", { silent = true, buffer = true })
                -- end,
                keymap = {
                    builtin = {
                        true,
                        ["<M-s-j>"] = "preview-down",
                        ["<M-s-k>"] = "preview-up",
                    },
                    fzf = {
                        true,
                        ["alt-a"] = "toggle-all",
                        ["alt-g"] = "first",
                        ["alt-G"] = "last",
                        ["alt-j"] = "down",
                        ["alt-k"] = "up",
                    }
                },
                previewers = {
                    actions = {
                        ["enter"]  = actions.keymap_apply,
                        ["ctrl-s"] = actions.keymap_split,
                        ["ctrl-v"] = actions.keymap_vsplit,
                        ["ctrl-t"] = actions.keymap_tabedit,
                    },
                }

            })
        end,
        keys = {
            {
                mode = "n",
                "<space>g",
                function()
                    vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
                        require("fzf-lua").lsp_workspace_symbols({ query = query })
                    end)
                end,
            },
            {
                mode = "n",
                "<space><space>",
                function()
                    if vim.bo.filetype ~= "qf" then
                        vim.api.nvim_command("FzfLua")
                    else
                        vim.api.nvim_command("normal! <CR>")
                    end
                end,
                desc = "Open fzf-lua",
            },
            {
                mode = "n",
                "<space>f",
                function()
                    require("fzf-lua").files({ fzf_colors = true })
                end,
                desc = "fzf finde files",
            },
            {
                mode = "n",
                "<space>c",
                function()
                    require("fzf-lua").commands()
                end,
                desc = "Fzf-lua show all commands",
            },
            {
                mode = "n",
                "<space>s",
                function()
                    require("fzf-lua").grep_project()
                end,
                desc = "Fzf-lua search",
            },
            {
                mode = "n",
                "<space>S",
                function()
                    require("fzf-lua").live_grep_resume()
                end,
                desc = "Fzf-lua search",
            },
            {
                mode = "v",
                "<space>s",
                function()
                    local selected_text = require("utils.utils").get_visual_selection()
                    selected_text = string.gsub(selected_text, "\n", "")
                    require("fzf-lua").grep_visual()
                end,
                desc = "Fzf-lua visual search",
            },
            { mode = "n", "<space>b", function() require("fzf-lua").buffers() end },
            { mode = "n", "<space>r", function() require("fzf-lua").oldfiles() end },
            { mode = "n", "<space>q", function() require("fzf-lua").quickfix() end },
            { mode = "n", "<space>l", function() require("fzf-lua").loclist() end },
            { mode = "n", "<space>j", function() require("fzf-lua").jumps() end },
            {
                mode = "n",
                "<space>/",
                function()
                    -- local current_buffer = vim.api.nvim_get_current_buf()
                    -- local abs_path = vim.api.nvim_buf_get_name(current_buffer)
                    require("fzf-lua").grep_curbuf()
                end,
            },
            -- {
            --     mode = "v",
            --     "<space>/",
            --     function()
            --         local selected_text = require("utils.utils").get_visual_selection()
            --         selected_text = string.gsub(selected_text, "\n", "")
            --         local current_buffer = vim.api.nvim_get_current_buf()
            --         local abs_path = vim.api.nvim_buf_get_name(current_buffer)
            --         require("telescope").extensions.live_grep_args.live_grep_args({
            --             search_dirs = { abs_path },
            --             default_text = selected_text,
            --             path_display = { "hidden" },
            --         })
            --     end,
            -- },
            {
                mode = "n",
                "<space>?",
                function()
                    require("fzf-lua").lsp_workspace_diagnostics()
                end
            },
            -- {
            --     mode = "v",
            --     "<space>?",
            --     function()
            --         local selected_text = require("utils.utils").get_visual_selection()
            --         selected_text = string.gsub(selected_text, "\n", "")
            --         require("telescope.builtin").diagnostics({ default_text = selected_text })
            --     end,
            -- },
        },
    }
}

local open_or_switch = function()
    local gp = require("gp")

    local last = gp.config.chat_dir .. "/last.md"
    if vim.fn.filereadable(last) ~= 1 then
        vim.api.nvim_command("GpChatNew vsplit")
        return vim.api.nvim_get_current_buf()
    end

    local target = gp.resolve_buf_target(gp.config.toggle_target)

    last = vim.fn.resolve(last)
    local buf = require("utils.utils").get_bufnr_by_file_name(last)
    local win_found = false
    if buf then
        for _, w in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(w) == buf then
                vim.api.nvim_set_current_win(w)
                vim.api.nvim_set_current_buf(buf)
                win_found = true
                break
            end
        end
    end

    buf = win_found and buf or gp.open_buf(last, target, gp._toggle_kind.chat, true)
    return buf
end

local _M = {
    {
        "robitx/gp.nvim",
        enabled = true,
        opts = {
            openai_api_key = os.getenv("OPENAI_API_KEY"),
            openai_api_endpoint = os.getenv("OPENAI_API_ENDPOINT"),
            state_dir = require("config").notes_home .. "/other/gp/persisted",
            chat_dir = require("config").notes_home .. "/other/gp/chats",
            chat_user_prefix = "🗨:[user]",
            chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
            chat_shortcut_respond = { modes = { "n", "v", "x" }, shortcut = "<cr>" },
            chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>d" },
            chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>s" },
            chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>c" },
        },
        cmd = { "GpChatNew" },
        keys = {
            {
                mode = "n",
                "<leader>a",
                function()
                    vim.api.nvim_command("GpAppend")
                end,
                desc = "Append to chat",
            },
            {
                mode = "n",
                "<cr>",
                function()
                    local gp = require("gp")
                    local cbuf = vim.api.nvim_get_current_buf()
                    local buftype = vim.api.nvim_get_option_value("buftype", { buf = cbuf })
                    local filetype = vim.api.nvim_get_option_value("filetype", { buf = cbuf })

                    local status_ok, obs = pcall(require, "obsidian")
                    if status_ok then
                        if obs.util.cursor_on_markdown_link() then
                            vim.api.nvim_command("ObsidianFollowLink")
                            return
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, true, true), "n", true)
                        end
                    end

                    if filetype ~= "qf" and filetype ~= "neo-tree" and filetype ~= "aerial" then
                        if not gp.can_handle(cbuf) then
                            gp.warning("Another plugin is handling this buffer")
                        end

                        local file_name = vim.api.nvim_buf_get_name(cbuf)
                        if not gp.is_chat(cbuf, file_name) then
                            open_or_switch()
                            vim.api.nvim_command("setlocal nonumber")
                            vim.api.nvim_command("setlocal signcolumn=no")
                        else
                            vim.api.nvim_command("GpChatRespond")
                        end
                    else
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, true, true), "n", true)
                    end
                end,
                desc = "Chat with AI",
            },
            {
                mode = "v",
                "<cr>",
                function()
                    local selected_text = require("utils.utils").get_visual_selection()
                    vim.ui.input({ prompt = "ai prompt: ", default = "" }, function(input_text)
                        if input_text == nil then
                            return
                        end
                        if input_text ~= "" then
                            selected_text = input_text .. "\n" .. selected_text
                        end

                        local buf = open_or_switch()

                        local last_line = vim.api.nvim_buf_line_count(buf)
                        while last_line > 0 do
                            local content = vim.api.nvim_buf_get_lines(buf, last_line - 1, last_line, false)[1]
                            if content:match("%S") then
                                break
                            end
                            last_line = last_line - 1
                        end
                        local lines = vim.split("\n" .. selected_text, "\n")
                        vim.api.nvim_buf_set_lines(buf, last_line, -1, false, lines)

                        if input_text ~= "" then
                            vim.api.nvim_command("GpChatRespond")
                        end
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("G", true, false, true), "n", true)
                        vim.api.nvim_command("setlocal nonumber")
                        vim.api.nvim_command("setlocal signcolumn=no")
                        -- vim.api.nvim_command("setlocal statuscolumn=''")
                        -- vim.api.nvim_buf_set_option_value("buftype", "gp", { buf = 0 })
                    end)
                end,
                desc = "Chat with AI",
            },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            panel = {
                enabled = false,
                auto_refresh = false,
                keymap = {
                    jump_prev = "<M-k>",
                    jump_next = "<M-j>",
                    accept = "<CR>",
                    refresh = "<M-r>",
                    open = "<M-CR>",
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<M-l>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-j>",
                    prev = "<M-k>",
                    dismiss = "<M-h>",
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["dap-repl"] = false,
                ["."] = false,
            },
            copilot_node_command = "node", -- Node.js version must be > 16.x
            server_opts_overrides = {},
        },
    },
}

return _M

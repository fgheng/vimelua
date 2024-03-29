local gp = require("gp")
gp.setup({
    openai_api_key = os.getenv("OPENAI_API_KEY"),
    openai_api_endpoint = os.getenv("OPENAI_API_ENDPOINT"),
    state_dir = require("config").notes_home .. "/gp/persisted",
    chat_dir = require("config").notes_home .. "/gp/chats",
    chat_user_prefix = "🗨:[user]",
    chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
    chat_shortcut_respond = { modes = { "n", "v", "x" }, shortcut = "<cr>" },
    chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>d" },
    chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>s" },
    chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>c" },
})
local last = gp.config.chat_dir .. "/last.md"

local opts = { noremap = true, silent = true }
local get_buffer = function(file_name)
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(b) then
            local buf_name = vim.api.nvim_buf_get_name(b)
            if file_name == "" or buf_name:sub(-#file_name) == file_name then
                return b
            end
        end
    end
    return nil
end

local open_or_switch = function()
    if vim.fn.filereadable(last) ~= 1 then
        vim.api.nvim_command("GpChatNew vsplit")
        return vim.api.nvim_get_current_buf()
    end

    local target = gp.resolve_buf_target(gp.config.toggle_target)

    last = vim.fn.resolve(last)
    local buf = get_buffer(last)
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

vim.keymap.set("v", "<cr>", function()
    local selected_text = require("utils").getVisualSelection()
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
end, opts)

vim.keymap.set("n", "<cr>", function()
    local cbuf = vim.api.nvim_get_current_buf()
    local buftype = vim.api.nvim_buf_get_option(cbuf, "buftype")
    -- local buftype = vim.api.nvim_buf_get_option_value("buftype", { buf = cbuf })
    local filetype = vim.api.nvim_buf_get_option(cbuf, "filetype")
    -- local filetype = vim.api.nvim_buf_get_option_value("filetype", { buf = cbuf })

    -- local status_ok_mkdn, _ = pcall(require, "mkdnflow")
    -- if status_ok_mkdn and filetype == "markdown" then
    --     local current_line = vim.api.nvim_get_current_line()
    --     local cursor_pos = vim.api.nvim_win_get_cursor(0)
    --     local char_under_cursor = current_line:sub(cursor_pos[2], cursor_pos[2]+1)
    --
    --     if char_under_cursor:match("%S") then
    --         vim.api.nvim_command("MkdnEnter")
    --         return
    --     end
    -- end

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
end, opts)

vim.keymap.set("n", "<leader>a", function()
    vim.api.nvim_command("GpAppend")
end, opts)

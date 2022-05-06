local function gp_open_or_switch()
    local gp = require("gp")

    local state_file = gp.config.state_dir .. "/state.json"
    local disk_state = {}
    if vim.fn.filereadable(state_file) ~= 0 then
        disk_state = gp.helpers.file_to_table(state_file) or {}
    end

    local last = disk_state.last_chat or ""
    if vim.fn.filereadable(last) ~= 1 then
        vim.api.nvim_command("GpChatNew vsplit")
        -- vim.api.nvim_command("setlocal nonumber")
        -- vim.api.nvim_command("setlocal signcolumn=no")
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
    vim.api.nvim_set_option_value("number", false, { scope = "local" })
    vim.api.nvim_set_option_value("signcolumn", "no", { scope = "local" })
    return buf
end

local _M = {
    {
        "robitx/gp.nvim",
        enabled = true,
        config = function()
            require("gp").setup({
                providers = {
                    openai = {
                        endpoint = os.getenv("OPENAI_API_ENDPOINT"),
                        secret = os.getenv("OPENAI_API_KEY"),
                    },
                },

                agents = {
                    {
                        provider = "openai",
                        name = "ChatGPT4o",
                        chat = true,
                        command = false,
                        -- string with model name or table with model name and parameters
                        model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
                        -- system prompt (use this to specify the persona/role of the AI)
                        system_prompt = require("gp.defaults").chat_system_prompt,
                    },
                    {
                        provider = "openai",
                        name = "ChatGPT4o-mini",
                        chat = true,
                        command = false,
                        -- string with model name or table with model name and parameters
                        model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
                        -- system prompt (use this to specify the persona/role of the AI)
                        system_prompt = require("gp.defaults").chat_system_prompt,
                    },
                    -- {
                    --     provider = "deepseek",
                    --     name = "deepseek",
                    --     chat = true,
                    --     command = false,
                    --     -- string with model name or table with model name and parameters
                    --     model = { model = "deepseek-chat", temperature = 1.1, top_p = 1 },
                    --     -- system prompt (use this to specify the persona/role of the AI)
                    --     system_prompt = require("gp.defaults").chat_system_prompt,
                    -- },
                },

                state_dir = require("config").notes_home .. "/gp/persisted",
                chat_dir = require("config").notes_home .. "/gp/chats",
                chat_user_prefix = "🗨:[user]",
                chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
                chat_shortcut_respond = { modes = { "n", "v", "x" }, shortcut = "<cr>" },
                chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>d" },
                chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>s" },
                chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-a>c" },
                hooks = {
                    CodeReview = function(gp, params)
                        local template = "I have the following code from {{filename}}:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please analyze for code smells and suggest improvements."
                            .. "请用中文回答"
                        local agent = gp.get_chat_agent()
                        gp.Prompt(params, gp.Target.enew("markdown"), nil, agent.model, template, agent.system_prompt)
                    end,
                    Explain = function(gp, params)
                        local template = "I have the following code from {{filename}}:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please respond by explaining the code above."
                            .. "请用中文回答"
                        local agent = gp.get_chat_agent()
                        gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
                    end,
                    -- example of adding command which opens new chat dedicated for translation
                    Translator = function(gp, params)
                        local agent = gp.get_command_agent()
                        local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
                        gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
                    end,
                },
            })
        end,
        opts = {},
        cmd = { "GpChatNew", "GpChatToggle", "GpAgent" },
        keys = {
            {
                mode = "n",
                "<cr>",
                function()
                    local cbuf = vim.api.nvim_get_current_buf()
                    local filetype = vim.api.nvim_get_option_value("filetype", { buf = cbuf })

                    if filetype ~= "qf" and filetype ~= "neo-tree" and filetype ~= "aerial" then
                        gp_open_or_switch()
                        vim.api.nvim_set_option_value("number", false, { scope = "local" })
                        vim.api.nvim_set_option_value("signcolumn", "no", { scope = "local" })
                        -- vim.api.nvim_set_option_value("scrolloff", 5, { scope = "local" })
                        -- vim.api.nvim_command("GpChatToggle")
                    else
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, true, true), "n", true)
                    end
                end,
                desc = "Chat with AI",
            },
            {
                mode = "n",
                "<s-enter>",
                function()
                    local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                    local prompt = "这是一份"
                        .. filetype
                        .. "文档，如果问题输出不是代码，那么请用注释的方式输出结果\n"
                    local current_line = vim.api.nvim_get_current_line()
                    prompt = prompt .. current_line
                    vim.api.nvim_command("GpAppend " .. prompt)
                end,
                desc = "Append",
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

                        local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                        local count = 80
                        for line in selected_text:gmatch("[^\n]+") do
                            -- local a, line_space_count = string.match(line, "^(%s*)")
                            local spaces = string.match(line, "^%s+")
                            if spaces ~= nil then
                                local line_space_count = string.len(spaces)
                                if line_space_count < count then
                                    count = line_space_count
                                end
                            end
                        end

                        local new_prompt = input_text .. "\n```" .. filetype .. "\n"
                        for line in selected_text:gmatch("[^\n]+") do
                            local new_line = line:gsub("^%s*", function(s)
                                return string.sub(s, count + 1)
                            end)
                            new_prompt = new_prompt .. new_line .. "\n"
                        end
                        new_prompt = new_prompt .. "```"

                        local buf = gp_open_or_switch()
                        vim.api.nvim_set_option_value("number", false, { scope = "local" })
                        vim.api.nvim_set_option_value("signcolumn", "no", { scope = "local" })
                        -- vim.api.nvim_set_option_value("scrolloff", 5, { scope = "local" })

                        local last_line = vim.api.nvim_buf_line_count(buf)
                        while last_line > 0 do
                            local content = vim.api.nvim_buf_get_lines(buf, last_line - 1, last_line, false)[1]
                            if content:match("%S") then
                                break
                            end
                            last_line = last_line - 1
                        end
                        local lines = vim.split("\n" .. new_prompt, "\n")
                        vim.api.nvim_buf_set_lines(buf, last_line, -1, false, lines)

                        if input_text ~= "" then
                            vim.api.nvim_command("GpChatRespond")
                        end
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("G", true, false, true), "n", true)
                    end)
                end,
                desc = "Chat with AI",
            },
            {
                mode = "v",
                "<s-enter>",
                function()
                    local selected_text = require("utils.utils").get_visual_selection()
                    vim.ui.input({ prompt = "ai prompt: ", default = "" }, function(input_text)
                        local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                        local prompt_new = "这是一份"
                            .. filetype
                            .. "代码，如果问题输出不是代码，那么请用注释的方式输出结果。\n"
                        if input_text ~= nil then
                            prompt_new = input_text .. "\n" .. selected_text
                        end

                        -- vim.api.nvim_command("GpRewrite " .. prompt_new)
                        vim.api.nvim_command("GpAppend " .. prompt_new)
                    end)
                end,
                desc = "Append",
            },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
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
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = false,
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            debug = false, -- Enable debugging
            -- See Configuration section for rest
        },
        cmd = {
            "CopilotChatOpen",
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
    {
        "luozhiya/fittencode.nvim",
        enabled = true,
        lazy = true,
        config = function()
            vim.opt.updatetime = 200
            require("fittencode").setup({
                disable_specific_inline_completion = {
                    -- Disable auto-completion for some specific file suffixes by entering them below
                    -- For example, `suffixes = {'lua', 'cpp'}`
                    suffixes = {},
                },
                inline_completion = {
                    -- Enable inline code completion.
                    ---@type boolean
                    enable = true,
                    -- Disable auto completion when the cursor is within the line.
                    ---@type boolean
                    disable_completion_within_the_line = false,
                    -- Disable auto completion when pressing Backspace or Delete.
                    ---@type boolean
                    disable_completion_when_delete = false,
                },
                delay_completion = {
                    -- Delay time for inline completion (in milliseconds).
                    ---@type integer
                    delaytime = 0,
                },
                -- Enable/Disable the default keymaps in inline completion.
                use_default_keymaps = true,
                -- Setting for source completion.
                source_completion = {
                    -- Enable source completion.
                    enable = true,
                    engine = "cmp",
                    -- trigger characters for source completion.
                    -- Available options:
                    -- * A  list of characters like {'a', 'b', 'c', ...}
                    -- * A function that returns a list of characters like `function() return {'a', 'b', 'c', ...}`
                    trigger_chars = {},
                },
                -- Set the mode of the completion.
                -- Available options:
                -- - 'inline' (default)
                -- - 'source'
                completion_mode = "inline",
                ---@class LogOptions
                log = {
                    level = vim.log.levels.WARN,
                },

                prompt = {
                    -- Maximum number of characters to prompt for completion/chat.
                    max_characters = 1000000,
                },

                chat = {
                    -- Highlight the conversation in the chat window at the current cursor position.
                    highlight_conversation_at_cursor = false,
                    -- Style
                    -- Available options:
                    -- * `sidebar` (Siderbar style, also default)
                    -- * `floating` (Floating style)
                    style = "sidebar",
                    sidebar = {
                        -- Width of the sidebar in characters.
                        width = require("config").ui.sidebar_width,
                        -- Position of the sidebar.
                        -- Available options:
                        -- * `left`
                        -- * `right`
                        position = "right",
                    },
                    floating = {
                        -- Border style of the floating window.
                        -- Same border values as `nvim_open_win`.
                        border = require("config").ui.float_ui_win.border,
                        -- Size of the floating window.
                        -- <= 1: percentage of the screen size
                        -- >  1: number of lines/columns
                        size = {
                            width = require("config").ui.float_ui_win.width,
                            height = require("config").ui.float_ui_win.height,
                        },
                    },
                },
            })
        end,
        event = "InsertEnter",
        keys = {
            {
                mode = "i",
                "<M-l>",
                function()
                    if require("fittencode").has_suggestions() then
                        -- require("fittencode").accept_line()
                        require("fittencode").accept_all_suggestions()
                    else
                        -- ignore
                    end
                end,
                { noremap = false },
            },
            {
                mode = "i",
                "<M-w>",
                function()
                    if require("fittencode").has_suggestions() then
                        require("fittencode").accept_word()
                    else
                        -- ignore
                    end
                end,
                { noremap = false },
            },
        },
    },

    {
        "yetone/avante.nvim",
        enabled = false,
        event = "VeryLazy",
        lazy = false,
        version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
        opts = {
            provider = "openai",
            openai = {
                -- endpoint = "https://api.openai.com/v1",
                -- endpoint = os.getenv("OPENAI_API_ENDPOINT"),
                endpoint = "https://api.ezchat.top/v1",
                model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
                timeout = 30000, -- timeout in milliseconds
                temperature = 0, -- adjust if needed
                max_tokens = 4096,
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            -- {
            --     -- Make sure to set this up properly if you have lazy=true
            --     "MeanderingProgrammer/render-markdown.nvim",
            --     opts = {
            --         file_types = { "markdown", "Avante" },
            --     },
            --     ft = { "markdown", "Avante" },
            -- },
        },
    },
}

return _M

require("neoai").setup({
    -- Below are the default options, feel free to override what you would like changed
    ui = {
        output_popup_text = "NeoAI",
        input_popup_text = "Prompt",
        width = 30, -- As percentage eg. 30%
        output_popup_height = 80, -- As percentage eg. 80%
    },
    models = {
        {
            name = "openai",
            model = "gpt-3.5-turbo",
        },
    },
    register_output = {
        ["g"] = function(output)
            return output
        end,
        ["c"] = require("neoai.utils").extract_code_snippets,
    },
    inject = {
        cutoff_width = 80,
    },
    prompts = {
        context_prompt = function(context)
            return "Hey, I'd like to provide some context for future "
                .. "messages. Here is the code/text that I want to refer "
                .. "to in our upcoming conversations:\n\n"
                .. context
        end,
    },
    open_ai = {
        api_key = {
            env = "OPENAI_API_KEY"
        }
    },
    shortcuts = {
        {
            name = "textify",
            key = "<leader>as",
            desc = "fix text with AI",
            use_context = true,
            prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
            modes = { "v" },
            strip_function = nil,
        },
        {
            name = "gitcommit",
            key = "<leader>ag",
            desc = "generate git commit message",
            use_context = false,
            prompt = function()
                return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
            end,
            modes = { "n" },
            strip_function = nil,
        },
    },
})

----------------------------------------------------------------------
--                              keymap                              --
----------------------------------------------------------------------
local opts = { silent = true, noremap = true }

vim.keymap.set("v", "<space>k", function()
    vim.ui.input({ prompt = "prompt:", default = "" }, function(input)
        if input == nil then
            return
        end

        input = input .. "\n"

        local selected_text = require("utils").getVisualSelection()
        selected_text = table.concat(selected_text, "\n")

        if string.len(selected_text) == 0 and string.len(input) == 0 then
            vim.notify("no content")
        else
            if vim.bo.modifiable then
                vim.api.nvim_command("NeoAIInject " .. input .. selected_text)
            else
                vim.notify("current file is not modifiable, show info in float window")
                vim.api.nvim_command("NeoAI " .. input .. selected_text)
            end
        end
    end)
end, opts)

vim.keymap.set("n", "<space>k", function()
    vim.ui.input({ prompt = "prompt:", default = "" }, function(input)
        if input == nil then
            return
        end
        if input == "" then
            vim.notify("no content")
        else
            vim.api.nvim_command("NeoAIInject " .. input)
        end
    end)
end, opts)

vim.keymap.set("v", "<cr>", function()
    vim.ui.input({ prompt = "prompts:", default = "" }, function(input)
        if input == nil then
            return
        end

        input = input .. "\n"
        local selected_text = require("utils").getVisualSelection()
        selected_text = table.concat(selected_text, "\n")

        if string.len(selected_text) == 0 and string.len(input) == 0 then
            vim.notify("no content")
        else
            vim.api.nvim_command("NeoAI " .. input .. selected_text)
        end
    end)
end)
vim.keymap.set("n", "<cr>", "<cmd>NeoAI<cr>", opts)

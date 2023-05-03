-- local status_ok, indent_blankline = pcall(require, 'indent_blankline')
-- if not status_ok then
--     vim.notify('indent-blankline not found')
--     return
-- end
local cmd = vim.api.nvim_command
cmd([[highlight IndentBlanklineIndent1 guifg=#a01022 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
-- cmd [[highlight IndentBlanklineContextChar guifg=#F8BD96 gui=nocombine]]

require("indent_blankline").setup({
    -- space_char_blankline = " ",
    -- char_highlight_list = {
    --     "IndentBlanklineIndent1",
    --     "IndentBlanklineIndent2",
    --     "IndentBlanklineIndent3",
    --     "IndentBlanklineIndent4",
    --     "IndentBlanklineIndent5",
    --     "IndentBlanklineIndent6",
    -- },
    show_current_context = true,
    -- show_current_context_start = true,
    -- show_end_of_line = true,
    user_treesitter = true,
    show_trailing_blankline_indent = false,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "startify",
        "dashboard",
        "dotooagenda",
        "log",
        "fugitive",
        "gitcommit",
        "packer",
        "vimwiki",
        "markdown",
        "txt",
        "vista",
        "help",
        "todoist",
        "NvimTree",
        "peekaboo",
        "git",
        "TelescopePrompt",
        "undotree",
        "flutterToolsOutline",
        "help",
        "startify",
        "aerial",
        "alpha",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "neo-tree",
        "Trouble",
        "", -- for all buffers without a file type
    },
    context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
    },
})

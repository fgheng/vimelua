local treesitter_config = require("nvim-treesitter.configs")
local languages = require("config").treesitter_languages
local disable_languages = require("config").treesitter_disable_languages

treesitter_config.setup({
    ensure_installed = languages,
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 2000
        end,
    },

    indent = {
        enable = false, -- do not change
    },

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },

    pairs = {
        enable = true,
        highlight_self = true,
    },

    autotag = {
        enable = true,
        filetypes = { "html", "xml" },
    },

    endwise = {
        enable = true,
    },

    -- vim-matchup
    matchup = {
        enable = true,
    },

    incremental_selection = {
        enable = true,
    },

    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                -- You can also use captures from other query groups like `locals.scm`
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["gF"] = "@function.outer",
                ["gC"] = { query = "@class.outer", desc = "Next class start" },
                --
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                ["gL"] = "@loop.*",
                -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                --
                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                -- ["]M"] = "@function.outer",
                -- ["]["] = "@class.outer",
            },
            goto_previous_start = {
                -- ["[m"] = "@function.outer",
                -- ["[["] = "@class.outer",
                ["gf"] = "@function.outer",
                ["gc"] = { query = "@class.outer", desc = "Next class start" },
                --
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                ["gl"] = "@loop.*",
            },
            goto_previous_end = {
                -- ["[M"] = "@function.outer",
                -- ["[]"] = "@class.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
                ["]d"] = "@conditional.outer",
            },
            goto_previous = {
                ["[d"] = "@conditional.outer",
            },
        },
    },
})

-- vim.api.nvim_command([[set foldmethod=expr]])
-- vim.api.nvim_command([[set foldexpr=nvim_treesitter#foldexpr()]])

----------------------------------------------------------------------
--                        treesitter-context                        --
----------------------------------------------------------------------
local context_status, treesitter_context = pcall(require, "treesitter-context")
if not context_status then
    vim.notify("treesitter-context not found")
    return
end

treesitter_context.setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
            "interface",
            "struct",
            "enum",
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        tex = {
            "chapter",
            "section",
            "subsection",
            "subsubsection",
        },
        haskell = {
            "adt",
        },
        rust = {
            "impl_item",
        },
        terraform = {
            "block",
            "object_elem",
            "attribute",
        },
        scala = {
            "object_definition",
        },
        vhdl = {
            "process_statement",
            "architecture_body",
            "entity_declaration",
        },
        markdown = {
            "section",
        },
        elixir = {
            "anonymous_function",
            "arguments",
            "block",
            "do_block",
            "list",
            "map",
            "tuple",
            "quoted_content",
        },
        json = {
            "pair",
        },
        typescript = {
            "export_statement",
        },
        yaml = {
            "block_mapping_pair",
        },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
})

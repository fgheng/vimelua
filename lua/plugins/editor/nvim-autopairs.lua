local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
    vim.notify("nvim-autopairs not found")
    return
end

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { "string" }, -- it will not add a pair on that treesitter node
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
    },

    fast_wrap = {
        -- map = "<M-e>",
        map = "<m-l>",
        chars = { "{", "[", "(", '"', "'" },
        -- pattern = string.gsub([[ [%'%"%)%>%]%)%}%,%;] ]], "%s+", ""),
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "l",
        -- offset = -1,
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = false,
        highlight = "Search",
        highlight_grey = "Comment",
    },
    disable_filetype = { "TelescopePrompt", "vim" },
    -- 如果存在 ) 那么输入( 不会变成()) 而是变成()
    -- 这样不是特别好用，所以关掉
    enable_check_bracket_line = false,
    -- 遇到字符数字不增加右括号
    -- ignored_next_char = "[%w%.]",
})

local rule = require("nvim-autopairs.rule")
-- local cond = require("nvim-autopairs.conds")

-- local ts_conds = require("nvim-autopairs.ts-conds")

npairs.add_rules({
    -- rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
    -- rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
    ----------------------------------------------------------------------
    --                  Add spaces between parentheses                  --
    --                         (|) space ( | )                          --
    --                           ( | ) ) ( )|                           --
    ----------------------------------------------------------------------
    rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),
    rule("( ", " )")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%)") ~= nil
        end)
        :use_key(")"),
    rule("{ ", " }")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%}") ~= nil
        end)
        :use_key("}"),
    rule("[ ", " ]")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%]") ~= nil
        end)
        :use_key("]"),
})

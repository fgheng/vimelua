local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
    vim.notify('nvim-autopairs not found')
    return
end

npairs.setup({
    fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,%;] ]], '%s+', ''),
        end_key = 'l',
        offset = -2,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
    },
    disable_filetype = { 'TelescopePrompt' , 'vim' },
    -- 如果存在 ) 那么输入( 不会变成()) 而是变成()
    -- 这样不是特别好用，所以关掉
    enable_check_bracket_line = false,
    -- 遇到字符数字不增加右括号
    -- ignored_next_char = "[%w%.]",
})

local rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
npairs.add_rules {
    ----------------------------------------------------------------------
    --                  Add spaces between parentheses                  --
    --                         (|) space ( | )                          --
    --                           ( | ) ) ( )|                           --
    ----------------------------------------------------------------------
    rule(' ', ' ')
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
    rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
        end)
        :use_key(')'),
    rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
    rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']'),
}

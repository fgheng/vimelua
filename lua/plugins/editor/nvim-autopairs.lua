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

    ----------------------------------------------------------------------
    --                        auto addspace on =                        --
    --                   local data| = local data =|                    --
    ----------------------------------------------------------------------
    rule('=', '')
        :with_pair(cond.not_inside_quote())
        :with_pair(function(opts)
            local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
            if last_char:match('[%w%=%s]') then
                return true
            end
            return false
        end)
        :replace_endpair(function(opts)
            local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
            local next_char = opts.line:sub(opts.col, opts.col)
            next_char = next_char == ' ' and '' or ' '
            if prev_2char:match('%w$') then
                return '<bs> =' .. next_char
            end
            if prev_2char:match('%=$') then
                return next_char
            end
            if prev_2char:match('=') then
                return '<bs><bs>=' .. next_char
            end
            return ''
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none())
}

local _M = {}
local cmd = vim.cmd
local o_s = vim.o
local map_key = vim.api.nvim_set_keymap

function _M.opt(o, v, scopes)
    scopes = scopes or { o_s }
    for _, s in ipairs(scopes) do s[o] = v end
end

_M.autocmd = function(group, cmds, clear)
    clear = clear == nil and false or clear
    if type(cmds) == 'string' then cmds = { cmds } end
    cmd('augroup ' .. group)
    if clear then cmd [[au!]] end
    for _, c in ipairs(cmds) do cmd('autocmd ' .. c) end
    cmd [[augroup END]]
end

_M.map = function(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    if type(modes) == 'string' then modes = { modes } end
    for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end

_M.isempty = function(s)
    return s == nil or s == ''
end

_M.get_buf_option = function(opt)
    local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end

_M.find_next_start = function(str, cur_idx)
    while cur_idx <= #str and str:sub(cur_idx, cur_idx) == ' ' do
        cur_idx = cur_idx + 1
    end
    return cur_idx
end

_M.str2argtable = function(str)
    if str == nil then return {} end
    str = string.gsub(str, '^%s*(.-)%s*$', '%1')
    local arg_list = {}

    local start = 1
    local i = 1
    local quote_refs_cnt = 0
    while i <= #str do
        local c = str:sub(i, i)
        if c == '"' then
            quote_refs_cnt = quote_refs_cnt + 1
            start = i
            i = i + 1
            -- find next quote
            while i <= #str and str:sub(i, i) ~= '"' do
                i = i + 1
            end
            if i <= #str then
                quote_refs_cnt = quote_refs_cnt - 1
                arg_list[#arg_list + 1] = str:sub(start, i)
                start = _M.find_next_start(str, i + 1)
                i = start
            end
            -- find next start
        elseif c == ' ' then
            arg_list[#arg_list + 1] = str:sub(start, i - 1)
            start = _M.find_next_start(str, i + 1)
            i = start
        else
            i = i + 1
        end
    end

    -- add last arg if possiable
    if start ~= i and quote_refs_cnt == 0 then
        arg_list[#arg_list + 1] = str:sub(start, i)
    end
    return arg_list
end

return _M

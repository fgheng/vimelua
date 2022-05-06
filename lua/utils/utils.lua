local _M = {}

---@param on_attach fun(client, buffer)
function _M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

function _M.get_visual_selection()
    -- vim.cmd([[noau normal! "vy"]])
    vim.api.nvim_command('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    if #text > 0 then
        return text
    else
        return ""
    end
end

-- function _M.get_buffer_by_file_name(file_name)
--     for _, b in ipairs(vim.api.nvim_list_bufs()) do
--         if vim.api.nvim_buf_get_name(b) then
--             local buf_name = vim.api.nvim_buf_get_name(b)
--             if file_name == "" or buf_name:sub(-#file_name) == file_name then
--                 return b
--             end
--         end
--     end
--     return nil
-- end

function _M.char_on_pos(pos)
    pos = pos or vim.fn.getpos(".")
    return tostring(vim.fn.getline(pos[1])):sub(pos[2], pos[2])
end

local function system(cmd)
    local output = vim.fn.system(cmd)
    -- To skip no needed terminal messages. Payload is last string.
    local lines = vim.split(vim.trim(output), "\n")
    return lines[#lines]
end

function _M.git_status()
    local status = {
        ---@type string Current git branch
        branch = "",
        ---@type string Short name of repo 'User/nameofrepo'
        repo = "",
        ---@type string Remote url of git repo
        remote_url = "",
        ---@type boolean If '.git' exist in current directory
        exist = false,
    }

    local skip = "\\(git@github.com:\\|https:\\/\\/github.com\\/\\|\\.git\\)"

    if vim.uv.fs_stat(vim.loop.cwd() .. "/.git") then
        status.exist = true
        status.branch = system("git branch --show-current")
        status.remote_url = system("git remote get-url --push origin")
        status.repo = vim.fn.substitute(status.remote_url, skip, "", "g")
    end

    return status
end

function _M.current_branch()
    if vim.uv.fs_stat(vim.loop.cwd() .. "/.git") then
        return vim.fn.system("git branch --show-current")
    end
    return ""
end

---Concatenate list-like tables
---@vararg table
---@return table
function _M.concat(...)
    local res = {}
    local l2 = { ... }
    for _, l in ipairs(l2) do
        for i = 1, #l do
            res[#res + 1] = l[i]
        end
    end
    return res
end

function _M.get_lsp_client_by_name(client_name)
    if client_name == nil then
        return nil
    end

    local active_clients = vim.lsp.get_clients({ name = client_name })

    if active_clients == {} then
        return nil
    end

    -- return first lsp server that is actually in use
    for _, v in ipairs(active_clients) do
        if v.attached_buffers ~= {} then
            return v.id
        end
    end
end

function _M.get_bufnr_by_file_name(file_name)
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

return _M

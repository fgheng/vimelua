local M = {}

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

-- 在这个函数中返回获取的可视区域文本
function M.getVisualSelection()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")
    local selected_text = vim.api.nvim_buf_get_lines(0, start_pos[1] - 1, end_pos[1], false)
    if start_pos[1] == end_pos[1] then
        selected_text[1] = string.sub(selected_text[1], start_pos[2] + 1, end_pos[2] + 1)
    else
        selected_text[1] = string.sub(selected_text[1], start_pos[2] + 1)
        selected_text[#selected_text] = string.sub(selected_text[#selected_text], 1, end_pos[2] + 1)
    end

    return selected_text
end

return M

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

function M.getVisualSelection()
    vim.cmd([[noau normal! "vy"]])
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    if #text > 0 then
        return text
    else
        return ""
    end
end

return M

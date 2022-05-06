vim.defer_fn(function()
    local api = vim.api

    api.nvim_create_autocmd("BufReadPost", {
        callback = function()
            local mark = vim.api.nvim_buf_get_mark(0, '"')
            local lcount = vim.api.nvim_buf_line_count(0)
            if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
        end,
    })

    -- highlight on yank
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.highlight.on_yank()
        end,
    })

    vim.api.nvim_create_user_command("DiffOrig", function()
        -- Get start buffer
        local start = vim.api.nvim_get_current_buf()

        -- `vnew` - Create empty vertical split window
        -- `set buftype=nofile` - Buffer is not related to a file, will not be written
        -- `0d_` - Remove an extra empty start row
        -- `diffthis` - Set diff mode to a new vertical split
        vim.cmd("vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis")

        -- Get scratch buffer
        local scratch = vim.api.nvim_get_current_buf()

        -- `wincmd p` - Go to the start window
        -- `diffthis` - Set diff mode to a start window
        vim.cmd("wincmd p | diffthis")

        -- Map `q` for both buffers to exit diff view and delete scratch buffer
        for _, buf in ipairs({ scratch, start }) do
            vim.keymap.set("n", "q", function()
                vim.api.nvim_buf_delete(scratch, { force = true })
                vim.keymap.del("n", "q", { buffer = start })
            end, { buffer = buf })
        end
    end, {})
end, 10)

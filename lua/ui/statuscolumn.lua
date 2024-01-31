vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.fillchars = "foldopen:,foldclose:"

local fcs = vim.opt.fillchars:get()

-- Stolen from Akinsho
local function get_fold(lnum)
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
        return " "
    end
    local fold_sym = vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
    return fold_sym
end

_G.get_statuscol = function()
    local cbuf = vim.api.nvim_get_current_buf()
    local filetype = vim.api.nvim_buf_get_option(cbuf, "filetype")

    if filetype == "neo-tree" or filetype == "aerial" or filetype == "toggleterm" then
        return ""
    else
        -- return "%@SignCb@%s%=%T%@NumCb@%l│" .. get_fold(vim.v.lnum) .. "%T"
        return "%s%=%l│" .. get_fold(vim.v.lnum) .. " "
    end
end

-- vim.o.statuscolumn = "%!v:lua.get_statuscol()"

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
        local winid = vim.api.nvim_get_current_win()
        vim.wo[winid].statuscolumn = "%!v:lua.get_statuscol()"
    end,
})

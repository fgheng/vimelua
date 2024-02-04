vim.opt.laststatus = 3
-- local api = vim.api
--
-- local L1 = "%#statusLineL1#[ %Y ] "
-- local L2 = "%#statusLineL2#[ %#statusLineL2#%F  %p%% ] "
-- local L3 = "%#statusLineL3#%{% &modified ? '%#statusLineR2#' : '%#statusLineL2#%r' %}"
--
-- local R1 = "%#statusLineR2# %#statusLineR1#%{strftime('%H:%M %a')} %#statusLineR3#• "
-- local R2 = "%#statusLine#[ %c%#statusLineR2#  %#statusLine#0𝙭%B ] "
-- local R3 = "%#statusLineR3#[ %l / %L ] "
--
-- vim.opt.statusline = "%#statusLineL0#▎" .. L1 .. L2 .. L3 .. "%=" .. R1 .. R2 .. R3
-- --
-- local StatusLineHL = {
--     statusLine = { bg = "NONE", fg = "#585858" },
--
--     statusLineL0 = { bg = "NONE", fg = "#333333" },
--     statusLineL1 = { bg = "NONE", fg = "#C53B82" },
--     statusLineL2 = { bg = "NONE", fg = "#444444" },
--     statusLineL3 = { bg = "NONE", fg = "#444444" },
--
--     statusLineR1 = { bg = "NONE", fg = "#444444" },
--     statusLineR2 = { bg = "NONE", fg = "#555555" },
--     -- statusLineR2 = { bg = "NONE", fg = "#AFC460" },
--     statusLineR3 = { bg = "NONE", fg = "#C53B82" },
-- }
--
-- for key, value in pairs(StatusLineHL) do
--     api.nvim_set_hl(0, key, value)
-- end

local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    ["␖"] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    ["␓"] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#StatusLineAccent#"
    if current_mode == "n" then
        mode_color = "%#StatuslineAccent#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatuslineInsertAccent#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "␖" then
        mode_color = "%#StatuslineVisualAccent#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineReplaceAccent#"
    elseif current_mode == "c" then
        mode_color = "%#StatuslineCmdLineAccent#"
    elseif current_mode == "t" then
        mode_color = "%#StatuslineTerminalAccent#"
    end
    return mode_color
end

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
    if fpath == "" or fpath == "." then
        return " "
    end

    return string.format(" %%<%s/", fpath)
end

local function filename()
    local fname = vim.fn.expand("%:t")
    if fname == "" then
        return ""
    end
    return fname .. " "
end

local function lsp()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " %#LspDiagnosticsSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#LspDiagnosticsSignInformation# " .. count["info"]
    end

    return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
    return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
    if vim.bo.filetype == "alpha" then
        return ""
    end
    return " %P %l:%c "
end

Statusline = {}

Statusline.active = function()
    return table.concat({
        "%#Statusline#",
        update_mode_colors(),
        mode(),
        "%#Normal# ",
        filepath(),
        filename(),
        "%#Normal#",
        lsp(),
        "%=%#StatusLineExtra#",
        filetype(),
        lineinfo(),
    })
end

vim.opt.statusline = Statusline.active()


-- function Statusline.inactive()
--     return " %F"
-- end
--
-- function Statusline.short()
--     return "%#StatusLineNC#   NvimTree"
-- end
--
-- vim.api.nvim_exec(
--     [[
--   augroup Statusline
--   au!
--   au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
--   au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
--   au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
--   augroup END
-- ]],
--     false
-- )

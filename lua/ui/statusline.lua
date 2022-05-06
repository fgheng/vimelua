-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

-- vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

local fn = vim.fn

local function stbufnr()
    return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

local function is_activewin()
    return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

local M = {}

M.modes = {
    ["n"] = { "NORMAL", "St_NormalMode" },
    ["no"] = { "NORMAL (no)", "St_NormalMode" },
    ["nov"] = { "NORMAL (nov)", "St_NormalMode" },
    ["noV"] = { "NORMAL (noV)", "St_NormalMode" },
    ["noCTRL-V"] = { "NORMAL", "St_NormalMode" },
    ["niI"] = { "NORMAL i", "St_NormalMode" },
    ["niR"] = { "NORMAL r", "St_NormalMode" },
    ["niV"] = { "NORMAL v", "St_NormalMode" },
    ["nt"] = { "NTERMINAL", "St_NTerminalMode" },
    ["ntT"] = { "NTERMINAL (ntT)", "St_NTerminalMode" },

    ["v"] = { "VISUAL", "St_VisualMode" },
    ["vs"] = { "V-CHAR (Ctrl O)", "St_VisualMode" },
    ["V"] = { "V-LINE", "St_VisualMode" },
    ["Vs"] = { "V-LINE", "St_VisualMode" },
    [""] = { "V-BLOCK", "St_VisualMode" },

    ["i"] = { "INSERT", "St_InsertMode" },
    ["ic"] = { "INSERT (completion)", "St_InsertMode" },
    ["ix"] = { "INSERT completion", "St_InsertMode" },

    ["t"] = { "TERMINAL", "St_TerminalMode" },

    ["R"] = { "REPLACE", "St_ReplaceMode" },
    ["Rc"] = { "REPLACE (Rc)", "St_ReplaceMode" },
    ["Rx"] = { "REPLACEa (Rx)", "St_ReplaceMode" },
    ["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
    ["Rvc"] = { "V-REPLACE (Rvc)", "St_ReplaceMode" },
    ["Rvx"] = { "V-REPLACE (Rvx)", "St_ReplaceMode" },

    ["s"] = { "SELECT", "St_SelectMode" },
    ["S"] = { "S-LINE", "St_SelectMode" },
    ["␓"] = { "S-BLOCK", "St_SelectMode" },
    ["c"] = { "COMMAND", "St_CommandMode" },
    ["cv"] = { "COMMAND", "St_CommandMode" },
    ["ce"] = { "COMMAND", "St_CommandMode" },
    ["r"] = { "PROMPT", "St_ConfirmMode" },
    ["rm"] = { "MORE", "St_ConfirmMode" },
    ["r?"] = { "CONFIRM", "St_ConfirmMode" },
    ["x"] = { "CONFIRM", "St_ConfirmMode" },
    ["!"] = { "SHELL", "St_TerminalMode" },
}

function M.mode()
    if not is_activewin() then
        return ""
    end

    local m = vim.api.nvim_get_mode().mode
    local t = M.modes[m] or { "UNKNOWN", "DiffText" }
    return "%#" .. t[2] .. "#" .. "  " .. t[1] .. " "
end

function M.fileInfo()
    local icon = "󰈚 "
    local path = vim.api.nvim_buf_get_name(stbufnr())
    local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")

    if name ~= "Empty " then
        local devicons_present, devicons = pcall(require, "nvim-web-devicons")

        if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
        end

        name = " " .. name .. " "
    end

    return "%#St_Text# " .. icon .. name
end

function M.git()
    if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
        return ""
    end

    return " %#St_Branch#"
        .. require("utils.icons").git.branch
        .. " "
        .. "%#St_Text#"
        .. vim.b[stbufnr()].gitsigns_status_dict.head
end

function M.gitchanges()
    if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status or vim.o.columns < 120 then
        return ""
    end

    local git_status = vim.b[stbufnr()].gitsigns_status_dict

    local added = (git_status.added and git_status.added ~= 0)
            and (" %#St_GitAdd#" .. require("utils.icons").icons.dot .. "" .. git_status.added)
        or " %#St_GitAdd#" .. require("utils.icons").icons.dot .. "0"
    local changed = (git_status.changed and git_status.changed ~= 0)
            and (" %#St_GitMod#" .. require("utils.icons").icons.dot .. "" .. git_status.changed)
        or " %#St_GitMod#" .. require("utils.icons").icons.dot .. "0"
    local removed = (git_status.removed and git_status.removed ~= 0)
            and (" %#St_GitDel#" .. require("utils.icons").icons.dot .. "" .. git_status.removed)
        or " %#St_GitDel#" .. require("utils.icons").icons.dot .. "0"

    return (added .. changed .. removed) ~= "" and (added .. changed .. removed .. " %#St_Text# ") or ""
end

-- LSP STUFF
function M.LSP_progress()
    local lsp = vim.lsp.status()
    if lsp ~= "" then
        local spinners = require("utils.icons").spinners.dots
        local ms = vim.uv.hrtime() / 1000000
        local frame = math.floor(ms / 120) % #spinners
        local content = string.format(" %%<%s %s ", spinners[frame + 1], string.match(lsp, "%S+"))

        return content
    else
        return ""
    end
end

function M.LSP_Diagnostics()
    if not rawget(vim, "lsp") then
        return " " .. require("utils.icons").symbols.error .. " 0 " .. require("utils.icons").symbols.warning .. " 0 "
    end

    local errors = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
    local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
    local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

    local errors_str = (errors and errors > 0)
            and ("%#St_Error#" .. require("utils.icons").symbols.error .. " " .. errors .. " ")
        or "%#St_Error#" .. require("utils.icons").symbols.error .. " 0 "
    local warnings_str = (warnings and warnings > 0)
            and ("%#St_Warning#" .. require("utils.icons").symbols.warning .. " " .. warnings .. " ")
        or "%#St_Warning#" .. require("utils.icons").symbols.warning .. " 0 "
    local hints_str = (hints and hints > 0)
            and ("%#St_Hint#" .. require("utils.icons").symbols.hint .. " " .. hints .. " ")
        or "%#St_Hint#" .. require("utils.icons").symbols.hint .. " 0 "
    local info_str = (info and info > 0) and ("%#St_Info#" .. require("utils.icons").symbols.info .. " " .. info .. " ")
        or "%#St_Info#" .. require("utils.icons").symbols.info .. " 0 "

    return vim.o.columns > 140 and errors_str .. warnings_str .. hints_str .. info_str or ""
end

function M.filetype()
    local ft = vim.bo[stbufnr()].ft
    return ft == "" and "{} plain text  " or "{} " .. ft .. " "
end

function M.LSP_status()
    if rawget(vim, "lsp") then
        for _, client in ipairs(vim.lsp.get_clients()) do
            if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
                return (vim.o.columns > 100 and " 󰄭  " .. client.name .. "  ") or " 󰄭  LSP  "
            end
        end
    end

    return ""
end

local function get_position()
    local pos = vim.api.nvim_win_get_cursor(0)
    local line = pos[1]
    local col = pos[2] + 1
    return string.format("%4d:%-3d ", line, col)
end
function M.cursor_position()
    return vim.o.columns > 140 and "%#St_Text#" .. get_position() or ""
end

function M.file_encoding()
    local encode = vim.bo[stbufnr()].fileencoding
    return string.upper(encode) == "" and "" or "%#St_encode#" .. string.upper(encode) .. "  "
end

function M.cwd()
    local dir_name = "%#St_Mode# 󰉖 " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
    return (vim.o.columns > 85 and dir_name) or ""
end

function M.run()
    local modules = {
        M.mode(),
        M.cwd(),
        M.fileInfo(),
        M.git(),
        M.gitchanges(),

        M.LSP_progress(),
        "%=",

        M.LSP_Diagnostics(),
        M.cursor_position(),
        M.file_encoding(),
        M.filetype(),
        M.LSP_status(),
    }

    return table.concat(modules)
    -- #StatuslineAccent#%#St_Mode#  NORMAL %#Normal# %#St_Mode# 󰉖 nvim %#St_Text#  init.lua   new_struct  ■ 0 ◉ 0 %=%= ~ 1 | %#St_Text# Ln %l, Col %c  %#St_encode#UTF-8  {} lua  󰄭  lua_ls
    -- %#DiffText#  NORMAL %#St_Mode# 󰉖 nvim %#St_Text#  statusline.lua   new_struct  %=%= + 327 ~ 185 - 701 | ■ 0 ◉ 1 | %#St_Text# Ln %l, Col %c  %#St_encode#UTF-8  {} lua  󰄭  lua_ls
end

StatusLine = M

vim.opt.statusline = "%!v:lua.StatusLine.run()"

return {}

-- local _M = {
--     {
--         "nvim-lualine/lualine.nvim",
--         enabled = true,
--         -- event = { "VeryLazy" },
--         event = { "UiEnter" },
--         dependencies = {
--             { "nvim-tree/nvim-web-devicons" },
--             { "arkav/lualine-lsp-progress" },
--         },
--         -- init = function()
--         --     vim.opt.showmode = false
--         --     vim.opt.laststatus = 3
--         -- end,
--         config = function()
--             local icons = require("utils.icons")
--             local hide_in_width = function()
--                 return vim.fn.winwidth(0) > 80
--             end
--
--             local diagnostics = {
--                 "diagnostics",
--                 sources = { "nvim_diagnostic" },
--                 colored = true,
--                 update_in_insert = false,
--                 always_visible = true,
--                 sections = { "info", "hint", "error", "warn" },
--                 symbols = {
--                     error = icons.symbols.error .. " ",
--                     warn = icons.symbols.warning .. " ",
--                     info = icons.symbols.info .. " ",
--                     hint = icons.symbols.hint .. " ",
--                 },
--             }
--
--             local diff = {
--                 "diff",
--                 colored = true,
--                 symbols = {
--                     added = icons.git.add .. " ",
--                     modified = icons.git.modify .. " ",
--                     removed = icons.git.remove .. " ",
--                 },
--                 -- cond = hide_in_width,
--             }
--
--             local mode = {
--                 "mode",
--                 fmt = function(str)
--                     return string.format("%7s", str)
--                 end,
--             }
--
--             local filetype = {
--                 "filetype",
--                 icons_enabled = true,
--                 icon = nil,
--             }
--
--             local filetype_winbar = {
--                 "filetype",
--                 icon_only = true,
--                 separator = "",
--             }
--
--             local branch = {
--                 "branch",
--                 icons_enabled = true,
--                 icon = icons.symbols.branch,
--             }
--
--             local location = {
--                 "location",
--                 padding = { left = 0, right = 0 },
--             }
--
--             local filename = {
--                 "filename",
--                 file_status = true,
--                 newfile_status = true,
--                 path = 1, -- 0: Just the filename
--                 -- 1: Relative path
--                 -- 2: Absolute path
--                 -- 3: Absolute path, with tilde as the home directory
--                 -- 4: Filename and parent dir, with tilde as the home directory
--                 fmt = function(filename)
--                     -- Small attempt to workaround https://github.com/nvim-lualine/lualine.nvim/issues/872
--                     if #filename > 80 then
--                         filename = vim.fs.basename(filename)
--                     end
--
--                     if #filename > 80 then
--                         return string.sub(filename, #filename - 80, #filename)
--                     end
--                     return filename
--                 end,
--             }
--
--             local filename_winbar_act = {
--                 "filename",
--                 file_status = false,
--                 path = 1,
--                 padding = { left = 1, right = 0 },
--                 color = { fg = "#FF9E3B", gui = "bold" },
--                 fmt = function(filename)
--                     return filename:gsub("/", " > ")
--                 end,
--             }
--
--             local filename_winbar_intact = {
--                 "filename",
--                 file_status = false,
--                 path = 1,
--                 padding = { left = 1, right = 0 },
--                 -- color = { fg = "ff9e64" },
--                 -- "filename",
--                 -- file_status = false,
--                 -- path = 1,
--                 -- padding = { left = 1, right = 0 },
--                 -- color = { fg = "#ff9e64", gui = "bold" },
--                 fmt = function(filename)
--                     return filename:gsub("/", " > ")
--                 end,
--             }
--
--             local navic = {
--                 function()
--                     local lc = require("nvim-navic").get_location({
--                         highlight = false,
--                         separator = " > ",
--                     })
--                     -- if lc ~= "" then
--                     --     lc = "> " .. lc
--                     -- end
--                     return lc
--                 end,
--                 -- cond = function()
--                 --     return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
--                 -- end,
--             }
--
--             local progress = {
--                 "progress",
--                 separator = "",
--                 padding = { left = 1, right = 1 },
--             }
--
--             local lsp_progress = {
--                 "lsp_progress",
--                 separators = {
--                     component = " ",
--                     progress = " ",
--                     message = { pre = " ", post = " " },
--                     percentage = { pre = "", post = "%% " },
--                     title = { pre = "", post = ": " },
--                     lsp_client_name = { pre = " ", post = " " },
--                     spinner = { pre = "", post = "" },
--                     -- message = { commenced = "In Progress", completed = "Completed" },
--                 },
--                 -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
--                 -- display_components = { "lsp_client_name", "spinner" },
--                 display_components = { "spinner", "lsp_client_name" },
--                 spinner_symbols = icons.spinners.dots,
--             }
--
--             local spaces = function()
--                 return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
--             end
--
--             local time = function()
--                 return os.date("%R")
--             end
--
--             local time_winbar = function()
--                 return os.date("%R")
--             end
--
--             local lazy = {
--                 function()
--                     return require("lazy.status").updates()
--                 end,
--                 cond = package.loaded["lazy"] and require("lazy.status").has_updates,
--                 color = { fg = "#ff9e64" },
--             }
--
--             local noice_command = {
--                 function()
--                     return require("noice").api.status.command.get()
--                 end,
--                 cond = function()
--                     return package.loaded["noice"] and require("noice").api.status.command.has()
--                 end,
--                 color = { fg = "ff9e64" },
--             }
--
--             local noice_mode = {
--                 function()
--                     return require("noice").api.status.mode.get()
--                 end,
--                 cond = function()
--                     return package.loaded["noice"] and require("noice").api.status.mode.has()
--                 end,
--             }
--
--             local noice_msg = {
--                 function()
--                     require("noice").api.status.message.get_hl()
--                 end,
--                 cond = package.loaded["noice"] and require("noice").api.status.message.has,
--             }
--
--             local noice_search = {
--                 function()
--                     require("noice").api.status.search.get()
--                 end,
--                 cond = package.loaded["noice"] and require("noice").api.status.search.has,
--                 color = { fg = "ff9e64" },
--             }
--
--             local lsp_status = {
--                 function()
--                     if rawget(vim, "lsp") then
--                         for _, client in ipairs(vim.lsp.get_clients()) do
--                             if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
--                                 return (vim.o.columns > 100 and " 󰄭  " .. client.name .. "  ") or " 󰄭  LSP  "
--                             end
--                         end
--                     end
--
--                     return ""
--                 end,
--             }
--
--             require("lualine").setup({
--                 options = {
--                     component_separators = { left = "", right = "" },
--                     section_separators = { left = "", right = "" },
--                     icons_enabled = true,
--                     theme = "auto",
--                     disabled_filetypes = {
--                         statusline = {},
--                         winbar = { "aerial", "NvimTree" },
--                     },
--                     always_divide_middle = true,
--                     globalstatus = true,
--                     refresh = {
--                         statusline = 500,
--                         tabline = 500,
--                         winbar = 100,
--                     },
--                 },
--
--                 sections = {
--                     lualine_a = {
--                         mode,
--                     },
--                     lualine_b = {},
--                     lualine_c = {
--                         branch,
--                         diff,
--
--                         filename,
--                         -- "aerial",
--                         lsp_progress,
--                     },
--                     lualine_x = {
--                         noice_msg,
--                         noice_search,
--                         noice_command,
--                         noice_mode,
--                         lazy,
--                         diagnostics,
--                         "encoding",
--                         "fileformat",
--                         filetype,
--
--                         -- "searchcount",
--                         progress,
--
--                         location,
--                         lsp_status,
--                     },
--                     lualine_y = {},
--                     lualine_z = {},
--                 },
--                 inactive_sections = {},
--                 tabline = {},
--                 extensions = {},
--             })
--         end,
--     },
-- }
--
-- return _M

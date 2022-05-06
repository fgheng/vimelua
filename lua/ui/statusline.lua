-- -- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
--
-- -- vim.opt.showmode = false
-- vim.opt.laststatus = 3
--
-- local fn = vim.fn
--
-- local function stbufnr()
--     return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
-- end
--
-- local function is_activewin()
--     return vim.api.nvim_get_current_win() == vim.g.statusline_winid
-- end
--
-- local M = {}
--
-- M.modes = {
--   ["n"] = { "NORMAL", "DiffText" },
--   ["no"] = { "NORMAL (no)", "DiffText" },
--   ["nov"] = { "NORMAL (nov)", "DiffText" },
--   ["noV"] = { "NORMAL (noV)", "DiffText" },
--   ["noCTRL-V"] = { "NORMAL", "DiffText" },
--   ["niI"] = { "NORMAL i", "DiffText" },
--   ["niR"] = { "NORMAL r", "DiffText" },
--   ["niV"] = { "NORMAL v", "DiffText" },
--   ["nt"] = { "NTERMINAL", "DiffText" },
--   ["ntT"] = { "NTERMINAL (ntT)", "DiffText" },
--
--   ["v"] = { "VISUAL", "DiffText" },
--   ["vs"] = { "V-CHAR (Ctrl O)", "DiffText" },
--   ["V"] = { "V-LINE", "DiffText" },
--   ["Vs"] = { "V-LINE", "DiffText" },
--   ["␖"] = { "V-BLOCK", "DiffText" },
--
--   ["i"] = { "INSERT", "DiffText" },
--   ["ic"] = { "INSERT (completion)", "DiffText" },
--   ["ix"] = { "INSERT completion", "DiffText" },
--
--   ["t"] = { "TERMINAL", "DiffText" },
--
--   ["R"] = { "REPLACE", "DiffText" },
--   ["Rc"] = { "REPLACE (Rc)", "DiffText" },
--   ["Rx"] = { "REPLACEa (Rx)", "DiffText" },
--   ["Rv"] = { "V-REPLACE", "DiffText" },
--   ["Rvc"] = { "V-REPLACE (Rvc)", "DiffText" },
--   ["Rvx"] = { "V-REPLACE (Rvx)", "DiffText" },
--
--   ["s"] = { "SELECT", "DiffText" },
--   ["S"] = { "S-LINE", "DiffText" },
--   ["␓"] = { "S-BLOCK", "DiffText" },
--   ["c"] = { "COMMAND", "DiffText" },
--   ["cv"] = { "COMMAND", "DiffText" },
--   ["ce"] = { "COMMAND", "DiffText" },
--   ["r"] = { "PROMPT", "DiffText" },
--   ["rm"] = { "MORE", "DiffText" },
--   ["r?"] = { "CONFIRM", "DiffText" },
--   ["x"] = { "CONFIRM", "DiffText" },
--   ["!"] = { "SHELL", "DiffText" },
-- }
--
-- M.mode = function()
--   if not is_activewin() then
--     return ""
--   end
--
--   local m = vim.api.nvim_get_mode().mode
--   local t = M.modes[m] or { "UNKNOWN", "DiffText" }
--   return "%#" .. t[2] .. "#" .. "  " .. t[1] .. " "
-- end
--
-- M.fileInfo = function()
--     local icon = "󰈚 "
--     local path = vim.api.nvim_buf_get_name(stbufnr())
--     local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")
--
--     if name ~= "Empty " then
--         local devicons_present, devicons = pcall(require, "nvim-web-devicons")
--
--         if devicons_present then
--             local ft_icon = devicons.get_icon(name)
--             icon = (ft_icon ~= nil and ft_icon) or icon
--         end
--
--         name = " " .. name .. " "
--     end
--
--     return "%#StText# " .. icon .. name
-- end
--
-- M.git = function()
--     if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
--         return ""
--     end
--
--     return " " .. require("utils.icons").symbols.branch .. " " .. vim.b[stbufnr()].gitsigns_status_dict.head .. "  "
-- end
--
-- M.gitchanges = function()
--     if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status or vim.o.columns < 120 then
--         return ""
--     end
--
--     local git_status = vim.b[stbufnr()].gitsigns_status_dict
--
--     local added = (git_status.added and git_status.added ~= 0)
--             and (" " .. require("utils.icons").git.add .. " " .. git_status.added)
--         or ""
--     local changed = (git_status.changed and git_status.changed ~= 0)
--             and (" " .. require("utils.icons").git.change .. " " .. git_status.changed)
--         or ""
--     local removed = (git_status.removed and git_status.removed ~= 0)
--             and (" " .. require("utils.icons").git.remove .. " " .. git_status.removed)
--         or ""
--
--     return (added .. changed .. removed) ~= "" and (added .. changed .. removed .. " | ") or ""
-- end
--
-- -- LSP STUFF
-- M.LSP_progress = function()
--     if not rawget(vim, "lsp") or vim.lsp.status or not is_activewin() then
--         return ""
--     end
--
--     -- local Lsp = vim.lsp.util.get_progress_messages()[1]
--     local Lsp = vim.lsp.status()[1]
--
--     if vim.o.columns < 120 or not Lsp then
--         return ""
--     end
--
--     if Lsp.done then
--         vim.defer_fn(function()
--             vim.cmd.redrawstatus()
--         end, 1000)
--     end
--
--     local msg = Lsp.message or ""
--     local percentage = Lsp.percentage or 0
--     local title = Lsp.title or ""
--     local spinners = require("utils.icons").spinners.dots
--     local ms = vim.loop.hrtime() / 1000000
--     local frame = math.floor(ms / 120) % #spinners
--     local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
--
--     return content or ""
-- end
--
-- M.LSP_Diagnostics = function()
--     if not rawget(vim, "lsp") then
--         return " " .. require("utils.icons").symbols.error .. " 0 " .. require("utils.icons").symbols.warning .. " 0 "
--     end
--
--     local errors = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
--     local warnings = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
--     local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
--     local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })
--
--     local errors_str = (errors and errors > 0) and (require("utils.icons").symbols.error .. " " .. errors .. " ")
--         or require("utils.icons").symbols.error .. " 0 "
--     local warnings_str = (warnings and warnings > 0) and (require("utils.icons").symbols.warning .. " " .. warnings .. " ")
--         or require("utils.icons").symbols.warning .. " 0 "
--     local hints_str = (hints and hints > 0) and (require("utils.icons").symbols.hint .. " " .. hints .. " ") or ""
--     local info_str = (info and info > 0) and (require("utils.icons").symbols.info .. " " .. info .. " ") or ""
--
--     return vim.o.columns > 140 and errors_str .. warnings_str .. hints_str .. info_str .. "| " or ""
-- end
--
-- M.filetype = function()
--     local ft = vim.bo[stbufnr()].ft
--     return ft == "" and "{} plain text  " or "{} " .. ft .. " "
-- end
--
-- M.LSP_status = function()
--     if rawget(vim, "lsp") then
--         for _, client in ipairs(vim.lsp.get_clients()) do
--             if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
--                 return (vim.o.columns > 100 and " 󰄭  " .. client.name .. "  ") or " 󰄭  LSP  "
--             end
--         end
--     end
--
--     return ""
-- end
--
-- M.cursor_position = function()
--     return vim.o.columns > 140 and "%#StText# Ln %l, Col %c  " or ""
-- end
--
-- M.file_encoding = function()
--     local encode = vim.bo[stbufnr()].fileencoding
--     return string.upper(encode) == "" and "" or "%#St_encode#" .. string.upper(encode) .. "  "
-- end
--
-- M.cwd = function()
--     local dir_name = "%#St_Mode# 󰉖 " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
--     return (vim.o.columns > 85 and dir_name) or ""
-- end
--
-- M.run = function()
--     local modules = {
--         M.mode(),
--         M.cwd(),
--         M.fileInfo(),
--         M.git(),
--
--         "%=",
--         M.LSP_progress(),
--         "%=",
--
--         M.gitchanges(),
--         M.LSP_Diagnostics(),
--         M.cursor_position(),
--         M.file_encoding(),
--         M.filetype(),
--         M.LSP_status(),
--     }
--
--     return table.concat(modules)
--     -- #StatuslineAccent#%#St_Mode#  NORMAL %#Normal# %#St_Mode# 󰉖 nvim %#StText#  init.lua   new_struct  ■ 0 ◉ 0 %=%= ~ 1 | %#StText# Ln %l, Col %c  %#St_encode#UTF-8  {} lua  󰄭  lua_ls
-- end
--
-- StatusLine = M
--
-- vim.opt.statusline = "%!v:lua.StatusLine.run()"
--
-- return {}
--

local _M = {
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        -- event = { "VeryLazy" },
        event = { "UiEnter" },
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "arkav/lualine-lsp-progress" },
        },
        -- init = function()
        --     vim.opt.showmode = false
        --     vim.opt.laststatus = 3
        -- end,
        config = function()
            local icons = require("utils.icons")
            local hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end

            local diagnostics = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                colored = true,
                update_in_insert = false,
                always_visible = true,
                sections = { "info", "hint", "error", "warn" },
                symbols = {
                    error = icons.symbols.error .. " ",
                    warn = icons.symbols.warning .. " ",
                    info = icons.symbols.info .. " ",
                    hint = icons.symbols.hint .. " ",
                },
            }

            local diff = {
                "diff",
                colored = true,
                symbols = {
                    added = icons.git.add .. " ",
                    modified = icons.git.modify .. " ",
                    removed = icons.git.remove .. " ",
                },
                -- cond = hide_in_width,
            }

            local mode = {
                "mode",
                fmt = function(str)
                    return string.format("%7s", str)
                end,
            }

            local filetype = {
                "filetype",
                icons_enabled = true,
                icon = nil,
            }

            local filetype_winbar = {
                "filetype",
                icon_only = true,
                separator = "",
            }

            local branch = {
                "branch",
                icons_enabled = true,
                icon = icons.symbols.branch,
            }

            local location = {
                "location",
                padding = { left = 0, right = 0 },
            }

            local filename = {
                "filename",
                file_status = true,
                newfile_status = true,
                path = 1, -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory
                -- 4: Filename and parent dir, with tilde as the home directory
                fmt = function(filename)
                    -- Small attempt to workaround https://github.com/nvim-lualine/lualine.nvim/issues/872
                    if #filename > 80 then
                        filename = vim.fs.basename(filename)
                    end

                    if #filename > 80 then
                        return string.sub(filename, #filename - 80, #filename)
                    end
                    return filename
                end,
            }

            local filename_winbar_act = {
                "filename",
                file_status = false,
                path = 1,
                padding = { left = 1, right = 0 },
                color = { fg = "#FF9E3B", gui = "bold" },
                fmt = function(filename)
                    return filename:gsub("/", " > ")
                end,
            }

            local filename_winbar_intact = {
                "filename",
                file_status = false,
                path = 1,
                padding = { left = 1, right = 0 },
                -- color = { fg = "ff9e64" },
                -- "filename",
                -- file_status = false,
                -- path = 1,
                -- padding = { left = 1, right = 0 },
                -- color = { fg = "#ff9e64", gui = "bold" },
                fmt = function(filename)
                    return filename:gsub("/", " > ")
                end,
            }

            local navic = {
                function()
                    local lc = require("nvim-navic").get_location({
                        highlight = false,
                        separator = " > ",
                    })
                    -- if lc ~= "" then
                    --     lc = "> " .. lc
                    -- end
                    return lc
                end,
                -- cond = function()
                --     return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                -- end,
            }

            local progress = {
                "progress",
                separator = "",
                padding = { left = 1, right = 1 },
            }

            local lsp_progress = {
                "lsp_progress",
                separators = {
                    component = " ",
                    progress = " ",
                    message = { pre = " ", post = " " },
                    percentage = { pre = "", post = "%% " },
                    title = { pre = "", post = ": " },
                    lsp_client_name = { pre = " ", post = " " },
                    spinner = { pre = "", post = "" },
                    -- message = { commenced = "In Progress", completed = "Completed" },
                },
                -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
                -- display_components = { "lsp_client_name", "spinner" },
                display_components = { "spinner", "lsp_client_name" },
                spinner_symbols = icons.spinners.dots,
            }

            local spaces = function()
                return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
            end

            local time = function()
                return os.date("%R")
            end

            local time_winbar = function()
                return os.date("%R")
            end

            -- local lazy = function()
            --     local s, ls = pcall(require, "lazy.status")
            --     if s and ls.has_updates() then
            --         return ls.updates()
            --     else
            --         return ""
            --     end
            -- end

            local lazy = {
                function()
                    return require("lazy.status").updates()
                end,
                cond = package.loaded["lazy"] and require("lazy.status").has_updates,
                color = { fg = "#ff9e64" },
            }

            local noice_command = {
                function()
                    return require("noice").api.status.command.get()
                end,
                cond = function()
                    return package.loaded["noice"] and require("noice").api.status.command.has()
                end,
                color = { fg = "ff9e64" },
            }

            local noice_mode = {
                function()
                    return require("noice").api.status.mode.get()
                end,
                cond = function()
                    return package.loaded["noice"] and require("noice").api.status.mode.has()
                end,
            }

            local noice_msg = {
                function()
                    require("noice").api.status.message.get_hl()
                end,
                cond = package.loaded["noice"] and require("noice").api.status.message.has,
            }

            local noice_search = {
                function()
                    require("noice").api.status.search.get()
                end,
                cond = package.loaded["noice"] and require("noice").api.status.search.has,
                color = { fg = "ff9e64" },
            }

            require("lualine").setup({
                options = {
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    icons_enabled = true,
                    theme = "auto",
                    disabled_filetypes = {
                        statusline = {},
                        winbar = { "aerial", "NvimTree" },
                    },
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 500,
                        tabline = 500,
                        winbar = 100,
                    },
                },

                sections = {
                    lualine_a = {
                        mode,
                    },
                    lualine_b = {},
                    lualine_c = {
                        branch,
                        diff,

                        filename,
                        -- "aerial",
                        lsp_progress,
                    },
                    lualine_x = {
                        noice_msg,
                        noice_search,
                        noice_command,
                        noice_mode,
                        lazy,
                        diagnostics,
                        "encoding",
                        "fileformat",
                        filetype,

                        -- "searchcount",
                        progress,

                        location,
                        time,
                    },
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_sections = {},
                tabline = {},
                extensions = {},
            })
        end,
    },

    {
        "rebelot/heirline.nvim",
        enabled = false,
        event = { "UiEnter" },
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        init = function()
            vim.opt.showmode = false
            vim.opt.laststatus = 2
        end,
        config = function()
            local conditions = require("heirline.conditions")
            local heirline = require("heirline")

            local utils = require("heirline.utils")

            local Space = { provider = " " }

            -- --------------------------------------------------------------
            local ViMode = {
                -- get vim current mode, this information will be required by the provider
                -- and the highlight functions, so we compute it only once per component
                -- evaluation and store it as a component attribute
                init = function(self)
                    self.mode = vim.fn.mode(1) -- :h mode()
                end,
                -- Now we define some dictionaries to map the output of mode() to the
                -- corresponding string and color. We can put these into `static` to compute
                -- them at initialisation time.
                static = {
                    mode_names = { -- change the strings if you like it vvvvverbose!
                        n = "N",
                        no = "N?",
                        nov = "N?",
                        noV = "N?",
                        ["no\22"] = "N?",
                        niI = "Ni",
                        niR = "Nr",
                        niV = "Nv",
                        nt = "Nt",
                        v = "V",
                        vs = "Vs",
                        V = "V_",
                        Vs = "Vs",
                        ["\22"] = "^V",
                        ["\22s"] = "^V",
                        s = "S",
                        S = "S_",
                        ["\19"] = "^S",
                        i = "I",
                        ic = "Ic",
                        ix = "Ix",
                        R = "R",
                        Rc = "Rc",
                        Rx = "Rx",
                        Rv = "Rv",
                        Rvc = "Rv",
                        Rvx = "Rv",
                        c = "C",
                        cv = "Ex",
                        r = "...",
                        rm = "M",
                        ["r?"] = "?",
                        ["!"] = "!",
                        t = "T",
                    },
                    mode_colors = {
                        n = "red",
                        i = "green",
                        v = "cyan",
                        V = "cyan",
                        ["\22"] = "cyan",
                        c = "orange",
                        s = "purple",
                        S = "purple",
                        ["\19"] = "purple",
                        R = "orange",
                        r = "orange",
                        ["!"] = "red",
                        t = "red",
                    },
                },
                -- We can now access the value of mode() that, by now, would have been
                -- computed by `init()` and use it to index our strings dictionary.
                -- note how `static` fields become just regular attributes once the
                -- component is instantiated.
                -- To be extra meticulous, we can also add some vim statusline syntax to
                -- control the padding and make sure our string is always at least 2
                -- characters long. Plus a nice Icon.
                provider = function(self)
                    return " %2(" .. self.mode_names[self.mode] .. "%)"
                end,
                -- Same goes for the highlight. Now the foreground will change according to the current mode.
                hl = function(self)
                    local mode = self.mode:sub(1, 1) -- get only the first mode character
                    return { fg = self.mode_colors[mode], bold = true }
                end,
                -- Re-evaluate the component only on ModeChanged event!
                -- Also allows the statusline to be re-evaluated when entering operator-pending mode
                update = {
                    "ModeChanged",
                    pattern = "*:*",
                    callback = vim.schedule_wrap(function()
                        vim.cmd("redrawstatus")
                    end),
                },
            }
            -- --------------------------------------------------------------
            local FileNameBlock = {
                -- let's first set up some attributes needed by this component and it's children
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
            }
            -- We can now define some children separately and add them later

            local FileIcon = {
                init = function(self)
                    local filename = self.filename
                    local extension = vim.fn.fnamemodify(filename, ":e")
                    self.icon, self.icon_color =
                        require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
                end,
                provider = function(self)
                    return self.icon and (self.icon .. " ")
                end,
                hl = function(self)
                    return { fg = self.icon_color }
                end,
            }

            local FileName = {
                provider = function(self)
                    -- first, trim the pattern relative to the current directory. For other
                    -- options, see :h filename-modifers
                    local filename = vim.fn.fnamemodify(self.filename, ":.")
                    if filename == "" then
                        return "[No Name]"
                    end
                    -- now, if the filename would occupy more than 1/4th of the available
                    -- space, we trim the file path to its initials
                    -- See Flexible Components section below for dynamic truncation
                    if not conditions.width_percent_below(#filename, 0.5) then
                        filename = vim.fn.pathshorten(filename)
                    end
                    return filename
                end,
                hl = { fg = utils.get_highlight("Directory").fg },
            }

            local FileFlags = {
                {
                    condition = function()
                        return vim.bo.modified
                    end,
                    provider = "[+]",
                    hl = { fg = "green" },
                },
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "",
                    hl = { fg = "orange" },
                },
            }

            -- Now, let's say that we want the filename color to change if the buffer is
            -- modified. Of course, we could do that directly using the FileName.hl field,
            -- but we'll see how easy it is to alter existing components using a "modifier"
            -- component

            local FileNameModifer = {
                hl = function()
                    if vim.bo.modified then
                        -- use `force` because we need to override the child's hl foreground
                        return { fg = "cyan", bold = true, force = true }
                    end
                end,
            }

            -- let's add the children to our FileNameBlock component
            FileNameBlock = utils.insert(
                FileNameBlock,
                FileIcon,
                utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
                FileFlags,
                { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
            )
            -- --------------------------------------------------------------
            -- We're getting minimalists here!
            local Ruler = {
                -- %l = current line number
                -- %L = number of lines in the buffer
                -- %c = column number
                -- %P = percentage through file of displayed window
                provider = "%7(%l/%3L%):%2c %P",
            }
            -- --------------------------------------------------------------

            local LSPActive = {
                condition = conditions.lsp_attached,
                update = { "LspAttach", "LspDetach" },

                -- You can keep it simple,
                -- provider = " [LSP]",

                -- Or complicate things a bit and get the servers names
                provider = function()
                    local names = {}
                    for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                        table.insert(names, server.name)
                    end
                    return " " .. table.concat(names, ",")
                end,
                hl = { fg = "green", bold = true },
            }
            -- local LSPMessages = {
            --     provider = require("lsp-status").status(),
            --     hl = { fg = "gray" },
            -- }
            -- --------------------------------------------------------------
            local Diagnostics = {

                condition = conditions.has_diagnostics,

                static = {
                    -- these require something...
                    -- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
                    -- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
                    -- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
                    -- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
                },

                init = function(self)
                    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                end,

                update = { "DiagnosticChanged", "BufEnter" },

                {
                    provider = function(self)
                        -- 0 is just another output, we can decide to print it or not!
                        return self.errors > 0 and (require("utils.icons").symbols.square .. self.errors .. " ")
                    end,
                    -- hl = { fg = "diag_error" },
                },
                {
                    provider = function(self)
                        return self.warnings > 0 and (require("utils.icons").symbols.square .. self.warnings .. " ")
                    end,
                    -- hl = { fg = "diag_warn" },
                },
                {
                    provider = function(self)
                        return self.info > 0 and (require("utils.icons").symbols.square .. self.info .. " ")
                    end,
                    -- hl = { fg = "diag_info" },
                },
                {
                    provider = function(self)
                        return self.hints > 0 and (require("utils.icons").symbols.square .. self.hints)
                    end,
                    -- hl = { fg = "diag_hint" },
                },
            }
            -- --------------------------------------------------------------
            -- local DAPMessages = {
            --     condition = function()
            --         local session = require("dap").session()
            --         return session ~= nil
            --     end,
            --     provider = function()
            --         return " " .. require("dap").status()
            --     end,
            --     hl = "Debug",
            --     -- see Click-it! section for clickable actions
            -- }
            -- --------------------------------------------------------------
            local WorkDir = {
                provider = function()
                    local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
                    local cwd = vim.fn.getcwd(0)
                    cwd = vim.fn.fnamemodify(cwd, ":~")
                    if not conditions.width_percent_below(#cwd, 0.25) then
                        cwd = vim.fn.pathshorten(cwd)
                    end
                    local trail = cwd:sub(-1) == "/" and "" or "/"
                    return icon .. cwd .. trail
                end,
                hl = { fg = "blue", bold = true },
            }
            -- --------------------------------------------------------------
            local Align = { provider = "%=" }
            -- ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })

            local DefaultStatusline = {
                ViMode,
                Space,
                FileNameBlock,
                Space,
                Align,
                Align,
                -- DAPMessages,
                LSPActive,
                Space,
                Diagnostics,
                Space,
                -- LSPMessages,
                Space,
                Ruler,
            }

            local FileType = {
                provider = function()
                    return string.upper(vim.bo.filetype)
                end,
                hl = { fg = utils.get_highlight("Type").fg, bold = true },
            }
            --
            local InactiveStatusline = {
                condition = conditions.is_not_active,
                FileNameBlock,
                Align,
            }

            local SpecialStatusline = {
                condition = function()
                    return conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "help", "quickfix" },
                        filetype = { "^git.*", "fugitive" },
                    })
                end,

                FileType,
                Space,
                Align,
            }
            local StatusLine = {

                hl = function()
                    if conditions.is_active() then
                        return "StatusLine"
                    else
                        return "StatusLineNC"
                    end
                end,

                -- the first statusline with no condition, or which condition returns true is used.
                -- think of it as a switch case with breaks to stop fallthrough.
                fallthrough = false,

                SpecialStatusline,
                InactiveStatusline,
                DefaultStatusline,
            }

            -- local Winbar = { { provider = "»" }, Space }
            -- local TabLine = {}
            -- local StatusColumn = {}

            heirline.setup({
                statusline = StatusLine,
                -- winbar = Winbar,
                -- tabline = TabLine,
                -- statuscolumn = StatusColumn
            })
        end,
    },
}

return _M

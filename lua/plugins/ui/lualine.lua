-- local status_ok, lualine = pcall(require, "lualine")
-- if not status_ok then
--     vim.notify("lualine not found")
--     return
-- end

local lualine = require("lualine")
local icons = require("ui.icons")

----------------------------------------------------------------------
--                        some funny config                         --
----------------------------------------------------------------------
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
        error = icons.error .. " ",
        warn = icons.warning .. " ",
        info = icons.info .. " ",
        hint = icons.hint .. " ",
    },
}

local diff = {
    "diff",
    colored = true,
    symbols = {
        added = icons.git_add .. " ",
        modified = icons.git_modified .. " ",
        removed = icons.git_remove .. " ",
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
    -- icons_enabled = true,
    -- icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = icons.branch,
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
    spinner_symbols = icons.spinner,
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local time = function()
    return icons.clock .. os.date("%R")
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
    cond = package.loaded["noice"] and require("noice").api.status.message.has
}

local noice_search = {
    function ()
        require("noice").api.status.search.get()
    end,
    cond = package.loaded["noice"] and require("noice").api.status.search.has,
    color = { fg = "ff9e64" },
}

----------------------------------------------------------------------
--                          lualine config                          --
----------------------------------------------------------------------
lualine.setup({
    options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        icons_enabled = true,
        theme = "auto", -- require("config").colorscheme.theme_group,
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
        },
        lualine_y = {},
        lualine_z = {
            time,
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
--    winbar = {
--        -- lualine_a = {},
--        -- lualine_b = {},
--        lualine_c = {
--            filename_winbar_act,
--            navic,
--        },
--        -- lualine_x = {},
--        -- lualine_y = {
--        --     -- time_winbar,
--        -- },
--        -- lualine_z = {},
--    },
--    inactive_winbar = {
--        -- lualine_a = {},
--        -- lualine_b = {},
--        lualine_c = {
--            filename_winbar_intact,
--            navic,
--        },
--        -- lualine_x = {
--        --     -- time_winbar,
--        -- },
--        -- lualine_y = {},
--        -- lualine_z = {},
--    },
    extensions = {},
})

lualine.hide({
    place = { "tabline" }, -- The segment this change applies to.
    unhide = false, -- whether to re-enable lualine again/
})

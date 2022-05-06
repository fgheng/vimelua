local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
    vim.notify('lualine not found')
    return
end

local icons_git = require('plugins.theme.icons').git
local icons_signs = require('plugins.theme.icons').signs

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn' },
    symbols = { error = icons_signs.error .. ' ', warn = icons_signs.warning .. ' ' },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    'diff',
    colored = false,
    symbols = { added = icons_git.line_add .. ' ', modified = icons_git.line_modified .. ' ', removed = icons_git.line_removed .. ' ' },
    cond = hide_in_width,
}

local mode = {
    'mode',
    fmt = function(str)
        return string.format('%7s', str)
    end,
}

local filetype = {
    'filetype',
    icons_enabled = true,
    icon = nil,
}

local branch = {
    'branch',
    icons_enabled = true,
    icon = icons_git.branch
}

local location = {
    'location',
    padding = 0,
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    -- local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
    local chars = { '██', '▇▇', '▆▆', '▅▅', '▄▄', '▃▃', '▂▂', '▁▁', '__', '  ' }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

lualine.setup {
    options = {
        -- globalstatus = true,
        -- icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- disabled_filetypes = { 'alpha', 'dashboard', 'toggleterm' },
        -- always_divide_middle = true,
        icons_enabled = true,
        theme = 'auto',
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {},
        lualine_b = { mode },
        lualine_c = { branch, diagnostics, { 'filename', path = 1 } },
        lualine_x = { diff, spaces, 'encoding', filetype, location, progress },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}

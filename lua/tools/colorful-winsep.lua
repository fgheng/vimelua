local _M = {
    "nvim-zh/colorful-winsep.nvim",
    enabled = false,
    event = { "WinNew" },
    config = function()
        require("colorful-winsep").setup({
            -- This plugin will not be activated for filetype in the following table.
            no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
            -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
            symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
            anchor = {
                left = { height = 1, x = -1, y = -1 },
                right = { height = 1, x = -1, y = 0 },
                up = { width = 0, x = -1, y = 0 },
                bottom = { width = 0, x = 1, y = 0 },
            },
        })
    end,
}

return _M

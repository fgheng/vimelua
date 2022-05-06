require("heirline").setup({
    statusline = { -- statusline
    },
    winbar = { -- winbar
    },
    tabline = { -- bufferline
    },
    statuscolumn = vim.fn.has("nvim-0.9") == 1 and {} or nil,
})

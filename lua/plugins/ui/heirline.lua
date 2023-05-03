local status = require("utils.status")
require("heirline").setup({
    statusline = { -- statusline
    },
    winbar = { -- winbar
    },
    tabline = { -- bufferline
    },
    statuscolumn = {
        status.component.foldcolumn(),
        status.component.fill(),
        status.component.numbercolumn(),
        status.component.signcolumn()
    }
})

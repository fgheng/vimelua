local notify = require("notify")
require("notify").setup({
    render = "simple", -- default minimal simple compact
    -- stages = "fade", -- default fade_in_slide_out
    stages = "fade_in_slide_out",
    -- max_width = 80,
    minimum_width = 50,
    timeout = 5000,
    top_down = false,
    fps = 60,
    on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 1000 })
    end,
    -- background_colour = function ()
    --     return "#ff0000"
    -- end
})
vim.notify = notify

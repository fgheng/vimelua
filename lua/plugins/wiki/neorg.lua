-- local status_ok, neorg = pcall(require, "neorg")
-- if not status_ok then
--     vim.notify("neorg not found")
--     return
-- end

local config = require("config")

require("neorg").setup({
    -- configuration here
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = config.wiki_home .. "/work",
                    home = config.wiki_home .. "/home",
                },
            },
        },
    },
})

local config = require("config")

require("neorg").setup({
    -- configuration here
    load = {
        -- ["core.defaults"] = {},
        -- ["core.norg.dirman"] = {
        --     config = {
        --         workspaces = {
        --             work = config.wiki_home .. "/work",
        --             home = config.wiki_home .. "/home",
        --         },
        --     },
        -- },
        ["core.defaults"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    work = config.wiki_home .. "/work",
                    home = config.wiki_home .. "/home",
                },
            },
        },
        ["core.concealer"] = {},
        -- ["core.completion"] = {},
        -- ["cool.module"] = {}
    },
})

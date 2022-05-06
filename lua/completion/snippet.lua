local _M = {
    "L3MON4D3/LuaSnip",
    lazy = true,
    -- event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local luasnip = require("luasnip")

        luasnip.config.set_config({
            history = true,
        })

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = { -- load custom snippets
                require("config").snippet_path_vscode,
            },
        })

        luasnip.filetype_extend("ruby", { "rails" })
        luasnip.filetype_extend("typescript", { "javascript" })
    end,
}
return _M

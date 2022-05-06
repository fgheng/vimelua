-- local luasnip_status_ok, luasnip = pcall(require, "luasnip")
--
-- if not luasnip_status_ok then
--     vim.notify("luasnip not found")
--     return
-- end

local luasnip = require("luasnip")

luasnip.config.set_config({
    history = true,
})

-- require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
    paths = { -- load custom snippets
        require("config").snippet_path_vscode,
    },
})

luasnip.filetype_extend("ruby", { "rails" })
luasnip.filetype_extend("typescript", { "javascript" })

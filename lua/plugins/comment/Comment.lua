-- local status_ok, comment = pcall(require, 'Comment')
-- if not status_ok then
--     vim.notify('Comment not found')
--     return
-- end

require("Comment").setup({
    padding = true,
    -- 光标还在原来的位置
    sticky = true,
    ignore = nil,

    toggler = {
        line = "<leader>cl",
        block = "<leader>bl",
    },

    -- 这个是比如iw，aw这种的开头
    -- ctrl b slash iw 注释一个单词
    opleader = {
        line = "<leader>cc",
        block = "<leader>cb",
    },

    extra = {
        -- 在当前行之上添加注释
        above = "<leader>cO",
        -- 在当前行之下添加注释
        below = "<leader>co",
        -- 在当前行最后添加注释
        eol = "<leader>ca",
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---NOTE: If `mappings = false` then the plugin won't create any mappings
    ---@type boolean|table
    mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
        ---Extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = false,
    },

    pre_hook = nil,
    post_hook = nil,
})

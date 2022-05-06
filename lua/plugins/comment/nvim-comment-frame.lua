local status_ok, ncf = pcall(require, 'nvim-comment-frame')
if not status_ok then
    vim.notify('nvim-comment-frame not found')
    return
end

ncf.setup({
    -- if true, <leader>cf keymap will be disabled
    disable_default_keymap = false,

    -- -- adds custom keymap
    -- keymap = '<leader>df',
    -- multiline_keymap = '<leader>dm',

    -- start the comment with this string
    -- start_str = '//',

    -- end the comment line with this string
    -- end_str = '//',

    -- fill the comment frame border with this character
    -- fill_char = '-',

    -- width of the comment frame
    -- frame_width = 70,

    -- wrap the line after 'n' characters
    -- line_wrap_len = 50,

    -- automatically indent the comment frame based on the line
    auto_indent = true,

    -- add comment above the current line
    add_comment_above = true,

    -- configurations for individual language goes here
    languages = {
    }
})

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<leader>dl', '<cmd>lua require("nvim-comment-frame").add_comment()<cr>', opts)
vim.keymap.set('n', '<leader>dm', '<cmd>lua require("nvim-comment-frame").add_multiline_comment()<cr>', opts)

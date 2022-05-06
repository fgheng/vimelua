local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
    vim.notify('gitsigns not found')
    return
end

local icons_git = require('plugins.theme.icons').git
gitsigns.setup({
    signs = {
        add          = { hl = 'GitSignsAdd', text = icons_git.sign_add, numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = icons_git.sign_change, numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = icons_git.sign_delete, numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = icons_git.sign_topdelete, numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = icons_git.sign_changedelete, numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },

    current_line_blame = true,
    numhl = true,
    linehl = false,
    word_diff = false,
    signcolumn = true,
    attach_to_untracked = true,

    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },

    current_line_blame_formatter_opts = {
        relative_time = false,
    },

    max_file_length = 10000,
})

-- hunk
-- diff
-- preview
-- stage (hunk buffer)
-- unstage
-- reset (hunk buffer)

local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<leader>gj', '<cmd>lua require("gitsigns").next_hunk({navigation_message=true, preview=false})<cr>', opts)
vim.keymap.set('n', '<leader>gk', '<cmd>lua require("gitsigns").prev_hunk({navigation_message=true, preview=false})<cr>', opts)
vim.keymap.set('n', '<leader>gs', '<cmd>lua require("gitsigns").stage_hunk()<cr>', opts)
vim.keymap.set('n', '<leader>gsu', '<cmd>lua require("gitsigns").undo_stage_hunk()<cr>', opts)
vim.keymap.set('n', '<leader>gS', '<cmd>lua require("gitsigns").stage_buffer()<cr>', opts)
vim.keymap.set('n', '<leader>gu', '<cmd>lua require("gitsigns").reset_hunk()<cr>', opts)
vim.keymap.set('n', '<leader>gU', '<cmd>lua require("gitsings").reset_buffer()<cr>', opts)
vim.keymap.set('n', '<leader>gp', '<cmd>lua require("gitsigns").preview_hunk()<cr>', opts)
vim.keymap.set('n', '<leader>gd', function()
    local input = vim.fn.input('base: ')
    if not input then
        require('gitsigns').diffthis(input)
    else
        return
    end
end, opts)
vim.keymap.set('n', '<leader>gl', '<cmd>lua require("gitsigns").setqflist(0, {use_location_list=false, open=true})<cr>', opts)
vim.keymap.set('n', '<leader>gL', '<cmd>lua require("gitsigns").setqflist("all", {use_location_list=false, open=true})<cr>', opts)
vim.keymap.set('n', '<leader>gb', '<cmd>lua require("gitsigns").blame_line{full=true}<cr>', opts)
-- map('n', '<leader>gb', '<cmd>Gitsigns blame_line<cr>', opts)

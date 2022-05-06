local status_ok, vgit = pcall(require, 'vgit')
if not status_ok then
    vim.notify('vgit not found')
    return
end

vgit.setup({
    keymaps = {
        ['n <leader>gk'] = 'hunk_up',
        ['n <leader>gj'] = 'hunk_down',
        ['n <leader>gs'] = 'buffer_hunk_stage',
        ['n <leader>gu'] = 'buffer_hunk_reset',
        ['n <leader>gp'] = 'buffer_hunk_preview',
        ['n <leader>gb'] = 'buffer_blame_preview',
        ['n <leader>gd'] = 'buffer_diff_preview',
        ['n <leader>gh'] = 'buffer_history_preview',
        ['n <leader>gU'] = 'buffer_reset',
        ['n <leader>gB'] = 'buffer_gutter_blame_preview',
        ['n <leader>gl'] = 'project_hunks_preview',
        ['n <leader>gD'] = 'project_diff_preview',
        ['n <leader>gq'] = 'project_hunks_qf',
        ['n <leader>gx'] = 'toggle_diff_preference',
    },

    settings = {
        hls = {
            GitBackground = 'Normal',
            GitHeader = 'NormalFloat',
            GitFooter = 'NormalFloat',
            GitBorder = 'LineNr',
            GitLineNr = 'LineNr',
            GitComment = 'Comment',
        },
        -- -- 高亮数字列
        -- signs = {
        --     definitions = {
        --         GitSignsAdd = {
        --             texthl = nil,
        --             numhl = 'GitSignsAdd',
        --             icon = nil,
        --             linehl = nil,
        --             text = '',
        --         },
        --         GitSignsDelete = {
        --             texthl = nil,
        --             numhl = 'GitSignsDelete',
        --             icon = nil,
        --             linehl = nil,
        --             text = '',
        --         },
        --         GitSignsChange = {
        --             texthl = nil,
        --             numhl = 'GitSignsChange',
        --             icon = nil,
        --             linehl = nil,
        --             text = '',
        --         },
        --     },

        -- }
    },
})

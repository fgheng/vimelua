local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    vim.notify('telescope not found')
    return
end

local icons_signs = require('plugins.theme.icons').signs

telescope.setup({
    hide_numbers = false,
    defaults = {
        mappings = {
            i = {
                ['<c-j>'] = 'move_selection_next',
                ['<c-k>'] = 'move_selection_previous',
                ['<M-j>'] = 'move_selection_next',
                ['<M-k>'] = 'move_selection_previous',
                ['<c-v>'] = 'select_vertical',
                ['<c-s>'] = 'select_horizontal',
                ['<c-t>'] = 'select_tab'
            },
            n = {
                ['<c-j>'] = 'move_selection_next',
                ['<c-k>'] = 'move_selection_previous',
                ['<M-j>'] = 'move_selection_next',
                ['<M-k>'] = 'move_selection_previous',
                ['<c-v>'] = 'select_vertical',
                ['<c-s>'] = 'select_horizontal',
                ['<c-t>'] = 'select_tab',
                ['l'] = 'select_default',
                ['?'] = 'which_key',
            }
        },

        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            -- '--trim' -- add this value
        },

        prompt_prefix = ' ' .. icons_signs.search .. '  ',
        selection_caret = icons_signs.arrow_right .. '  ',
        path_display = { 'absolute'
            -- shorten = {
            -- e.g. for a path like
            --   `alpha/beta/gamma/delta.txt`
            -- setting `path_display.shorten = { len = 1, exclude = {1, -1} }`
            -- will give a path like:
            --   `alpha/b/g/delta.txt`
            -- len = 3, exclude = { 1, -1 }
            -- },
        },
        file_ignore_patterns = { 'node_modules' },
        layout_strategy = 'vertical', -- default horizontal,
        -- layout_config = {
        --     horizontal = {
        --         prompt_position = 'top',
        --         preview_width = 0.55,
        --         results_width = 0.8,
        --     },
        --     vertical = {
        --         mirror = true,
        --     },
        --     width = 0.8,
        --     height = 0.8,
        --     preview_cutoff = 120,
        -- },
        -- generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        winblend = 0,
        -- border = {},
        -- borderchars = { '' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' },
        -- file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        -- grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        -- qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        -- buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    },
})

telescope.load_extension('ui-select')
-- telescope.load_extension('emoji')
-- telescope.load_extension('fzf')
-- telescope.load_extension('live_grep_raw')

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<space><space>', '<cmd>Telescope<cr>', opts)
vim.keymap.set('n', '<space>f', '<cmd>Telescope find_files<cr>', opts)
vim.keymap.set('n', '<space>s', '<cmd>Telescope live_grep<cr>', opts)
vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>', opts)
vim.keymap.set('n', '?', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)
vim.keymap.set('n', '<space>a', '<cmd>Telescope diagnostics<cr>', opts)
vim.keymap.set('n', '<space>r', '<cmd>Telescope oldfiles<cr>', opts)
vim.keymap.set('n', '<space>j', '<cmd>Telescope jumplist<cr>', opts)

local status_ok, treesitter_config = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    vim.notify('nvim-treesitter not found')
    return
end

local languages = require('config').treesitter_languages

treesitter_config.setup({
    ensure_installed = languages,
    sync_install = false,

    highlight = {
        enable = true,
    disable = {'css', 'markdown'}
    },

    -- date: 2022.2
    -- Note that the indent feature with treesitter is still in beta. I recommend turning it off for now.
    indent = {
        enable = true,
      disable = { 'python', 'css'}
    },

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },

    pairs = {
        enable = true,
        highlight_self = true,
    },

    autotag = {
        enable = true
    },

    endwise = {
        enable = true,
    },

    -- vim-matchup
    matchup = {
        enable = true
    }
})

vim.cmd([[set foldmethod=expr]])
vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])

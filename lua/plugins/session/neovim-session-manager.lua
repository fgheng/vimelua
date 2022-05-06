local notify = vim.notify
local path = require('plenary.path')

local status_ok, session_manager = pcall(require, 'session_manager')
if not status_ok then
    notify('session_manager not found')
    return
end

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    notify('nvim-tree not found')
    return
else
    require('vime/nvim-tree')
end

local fn = vim.fn
local api = vim.api

session_manager.setup({
    sessions_dir = path:new(fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
    path_replacer = '__', -- The character to which the path separator will be replaced for session files.
    colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        'gitcommit',
    },
    autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 80,
})


local config_group = api.nvim_create_augroup('vimeGroup_nvim_tree', {})
api.nvim_create_autocmd({ 'SessionLoadPost' }, {
    group = config_group,
    callback = function()
        nvim_tree.toggle(false, true)
    end,
})

-- cmd [[
--     augroup vime_open_nvim_tree
--         autocmd! * <buffer>
--         autocmd SessionLoadPost * silent! lua require('nvim-tree').toggle(false, true)
--     augroup end
-- ]]

local status_ok, auto_session = pcall(require, 'auto_session')
if not status_ok then
    vim.notify('auto-session not found')
    return
end

auto_session.setup({
    auto_session_enabled = false,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_suppress_dirs = nil,
    auto_session_use_git_branch = true,
    -- the configs below are lua only
    bypass_session_save_file_types = nil,
    auto_session_enable_last_session = false,
})

local _M = {
    "aserowy/tmux.nvim",
    cond = function()
        return nil ~= os.getenv("TMUX")
    end,
    event = { "CursorMoved" }, -- is it reasonable?
    opts = {
        copy_sync = {
            enable = true,
        },
        navigation = {
            cycle_navigation = false,
            enable_default_keybindings = true,
            -- prevents unzoom tmux when navigating beyond vim border
            persist_zoom = false,
        },
        resize = {
            enable = false,
            -- default keys is (A-hkjl)
            enable_default_keybindings = false,
            -- sets resize steps for x axis
            resize_step_x = 1,
            -- sets resize steps for y axis
            resize_step_y = 1,
        },
    },
}
return _M

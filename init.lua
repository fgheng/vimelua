require("core")
require("plugins")
require("ui")

if vim.g.neovide then
    local g = vim.g
    g.neovide_scale_factor = 1.0
    g.neovide_transparency = 0.6
    g.transparency = 0.8
    g.neovide_floating_blur_amount_x = 2.0
    g.neovide_floating_blur_amount_y = 2.0
    g.neovide_scroll_animation_length = 0.3
    g.neovide_hide_mouse_when_typing = true
    g.neovide_underline_automatic_scaling = true
    g.neovide_no_idle = true
    g.neovide_confirm_quit = true
    g.neovide_fullscreen = false
    g.neovide_profiler = false
    g.neovide_input_use_logo = true -- true on macOS
    g.neovide_input_macos_alt_is_meta = true -- macos meta is alt

    --cursor
    -- g.neovide_cursor_animation_length=0.05
    -- g.neovide_cursor_trail_size = 0.8
    -- g.neovide_cursor_antialiasing = true
    -- g.neovide_cursor_unfocused_outline_width = 0.5
    g.neovide_cursor_vfx_mode = "wireframe" -- railgun torpedo pixiedust sonicboom  ripple wireframe

    if vim.o.background == "light" then
        vim.cmd([[
                let g:neovide_background_color = '#fdf7f0'.printf('%x', float2nr(255 * g:transparency))
            ]])
    else
        vim.cmd([[
                let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
            ]])
    end

    vim.cmd([[
            set guifont=ComicMono\ Nerd\ Font:h13
        ]])
end

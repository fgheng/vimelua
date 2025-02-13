require("core")
require("init")

if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.7
    vim.g.neovide_transparency = 0.8
    vim.g.transparency = 0.5
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_underline_automatic_scaling = true
    vim.g.neovide_no_idle = true
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_fullscreen = false
    vim.g.neovide_profiler = false
    vim.g.neovide_input_use_logo = true -- true on macOS
    vim.g.neovide_input_macos_option_key_is_meta = "only_left"
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5

    --cursor
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0.8
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_unfocused_outline_width = 0.5
    vim.g.neovide_cursor_vfx_mode = "railgun" -- railgun torpedo pixiedust sonicboom  ripple wireframe

    vim.o.linespace = 0
    -- vim.o.guifont = "ComicMono Nerd Font:h22:b"
    vim.g.neovide_text_gamma = 0.0
    vim.g.neovide_text_contrast = 0.5
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0
    vim.g.neovide_theme = "auto"

    vim.g.neovide_input_use_logo = true
    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", '<C-\\><C-o>"+p', { noremap = true, silent = true })
end

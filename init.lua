vim.loader.enable()
require("core")
require("init")

if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_transparency = 1.0
    vim.g.transparency = 0.8
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
    vim.g.neovide_input_macos_alt_is_meta = true -- macos meta is alt

    --cursor
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0.8
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_unfocused_outline_width = 0.5
    vim.g.neovide_cursor_vfx_mode = "railgun" -- railgun torpedo pixiedust sonicboom  ripple wireframe

    vim.api.nvim_set_option_value("guifont", "ComicMono Nerd Font:h16", {})

    -- Allow clipboard copy paste in neovim
    vim.g.neovide_input_use_logo = true
    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", '<C-\\><C-o>"+p', { noremap = true, silent = true })
end


vim.api.nvim_command([[
    let g:nvimgdb_disable_start_keymaps = 1
    let g:nvimgdb_use_find_executables = 0
    let g:nvimgdb_use_cmake_to_find_executables = 0
    let g:nvimgdb_config = {
      \ 'sign_current_line': '▶',
      \ 'sign_breakpoint': [ '●', '●²', '●³', '●⁴', '●⁵', '●⁶', '●⁷', '●⁸', '●⁹', '●ⁿ' ],
      \ 'sign_breakpoint_priority': 10,
      \ 'termwin_command': 'belowright 20sp new',
      \ 'codewin_command': 'new',
      \ 'set_scroll_off': 5,
      \ 'jump_bottom_gdb_buf': v:false,
    \ }
]])

_G.StartGdbSession = function()
    local exec_file = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    vim.api.nvim_command(":GdbStart gdb -q " .. exec_file)
end

_G.CreateWatch = function()
    vim.api.nvim_command(":GdbCreateWatch info locals")
    vim.api.nvim_command(":belowright GdbCreateWatch thread apply all bt")
end

local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<F4>', '<cmd>lua StartGdbSession()<cr>', opts)
keymap('n', '<F5>', '<cmd>GdbBreakpointToggle<cr>', opts)
keymap('n', '<F6>', '<cmd>GdbNext<cr>', opts)
keymap('n', '<F7>', '<cmd>GdbContinue<cr>', opts)
keymap('n', '<F8>', '<cmd>GdbDebugStop<cr>', opts)
keymap('n', '<F9>', '<cmd>lua CreateWatch()<cr>', opts)

-- local map = require('utils').map
-- local opts = { silent = true, noremap = true }

-- vim.g.copilot_no_tab_map = true
-- map('i', '<c-l>', '<c-u>call copilot#Accept("")<cr>', opts)

vim.cmd [[
    let g:copilot_filtype = {
        \ 'TelescopePrompt': v:false,
        \ 'TelescopeResults': v:false,
    \ }

    let g:copilot_no_tab_map = v:true
    imap <silent><script><expr> <m-l> copilot#Accept("")
    imap <silent> <m-h> <Plug>(copilot-dismiss)
    imap <silent> <m-L> <Plug>(copilot-next)
    imap <silent> <m-H> <Plug>(copilot-previous)
]]
-- local opts = {silent = true}
-- vim.keymap.set('i', '<M-l>', '<c-u><script><expr>call copilot#Accept("")<cr>', opts)

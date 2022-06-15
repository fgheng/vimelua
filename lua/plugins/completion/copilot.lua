vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
    ['*'] = false,
    ['javascript'] = true,
    ['typescript'] = true,
    ['lua'] = true,
    ['rust'] = true,
    ['c'] = true,
    ['c#'] = true,
    ['c++'] = true,
    ['go'] = true,
    ['python'] = true,
    ['dap-repl'] = false,
}


vim.cmd [[
    let g:copilot_no_tab_map = v:true
    imap <silent><script><expr> <m-l> copilot#Accept("")
    imap <silent> <m-h> <Plug>(copilot-dismiss)
    imap <silent> <m-L> <Plug>(copilot-next)
    imap <silent> <m-H> <Plug>(copilot-previous)
]]

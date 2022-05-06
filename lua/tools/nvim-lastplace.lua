local _M = {
    "ethanholz/nvim-lastplace",
    enabled = false,
    event = { "BufRead" },
    opts = {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
    },
}
return _M

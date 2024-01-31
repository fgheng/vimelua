vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.fillchars = "foldopen:,foldclose:"

local builtin = require("statuscol.builtin")
local fcs = vim.opt.fillchars:get()
local cfg = {
    setopt = true, -- Whether to set the 'statuscolumn' option, may be set to false for those who
    -- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
    -- Although I recommend just using the segments field below to build your
    -- statuscolumn to benefit from the performance optimizations in this plugin.
    -- builtin.lnumfunc number string options
    thousands = false, -- or line number thousands separator string ("." / ",")
    relculright = false, -- whether to right-align the cursor line number with 'relativenumber' set
    -- Builtin 'statuscolumn' options
    ft_ignore = nil, -- lua table with 'filetype' values for which 'statuscolumn' will be unset
    bt_ignore = nil, -- lua table with 'buftype' values for which 'statuscolumn' will be unset
    -- Default segments (fold -> sign -> line number + separator), explained below
    segments = {
        { text = { "%s" } },
        { text = { "%=", builtin.lnumfunc, "" } },
        { text = { "", "│", "" } },
        {
            text = {
                "",
                function(args)
                    local lnum = args.lnum
                    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
                        return " "
                    end
                    local fold_sym = vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
                    return fold_sym
                end,
                " ",
            },
            condition = {
                true,
                function(args)
                    return args.fold.width > 0
                end,
                true,
            },
        },
    },
}
require("statuscol").setup(cfg)

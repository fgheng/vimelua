vim.opt.signcolumn = "yes:1"
-- vim.opt.foldcolumn = "auto"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

local _M = {
    "luukvbaal/statuscol.nvim",
    enabled = false,
    -- event = { "BufReadPost" },
    event = { "UiEnter" },
    init = function()
        vim.opt.foldcolumn = "1"
    end,
    config = function()
        local builtin = require("statuscol.builtin")
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
            bt_ignore = { "nofile", "terminal" }, -- lua table with 'buftype' values for which 'statuscolumn' will be unset
            -- Default segments (fold -> sign -> line number + separator), explained below
            segments = {
                {
                    sign = {
                        name = { ".*" },
                        text = { ".*" },
                        colwidth = 1,
                        wrap = false,
                    },
                    click = "v:lua.ScSa",
                    condition = {
                        true
                        -- function()
                        --     local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                        --     return filetype ~= "markdown"
                        -- end,
                    },
                },
                {
                    text = { builtin.lnumfunc },
                    click = "v:lua.ScLa",
                    condition = {
                        true
                        -- function()
                        --     local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                        --     return filetype ~= "markdown"
                        -- end,
                    },
                },
                {
                    text = { " " },
                    condition = {
                        true
                        -- function()
                        --     local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                        --     return filetype ~= "markdown"
                        -- end,
                    },
                },
                -- {
                --     sign = { name = { "GitSigns" }, text = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true },
                --     fillchar = "%#LineNr#%=│",
                --     click = "v:lua.ScSa",
                -- },
                {
                    text = {
                        function(args)
                            args.fold.close = require("utils.icons").symbols.fold_close
                            args.fold.open = require("utils.icons").symbols.fold_open
                            args.fold.sep = "│"
                            return builtin.foldfunc(args)
                        end,
                    },
                    condition = {
                        true
                        -- function()
                        --     local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                        --     return filetype ~= "markdown"
                        -- end,
                        -- builtin.notempty, -- only shown when the rest of the statuscolumn is not empty
                    },
                    click = "v:lua.ScFa",
                },
                { text = { " " } },
                clickmod = "c", -- modifier used for certain actions in the builtin clickhandlers:
                -- "a" for Alt, "c" for Ctrl and "m" for Meta.
                clickhandlers = { -- builtin click handlers
                    Lnum = builtin.lnum_click,
                    FoldClose = builtin.foldclose_click,
                    FoldOpen = builtin.foldopen_click,
                    FoldOther = builtin.foldother_click,
                    DapBreakpointRejected = builtin.toggle_breakpoint,
                    DapBreakpoint = builtin.toggle_breakpoint,
                    DapBreakpointCondition = builtin.toggle_breakpoint,
                    DiagnosticSignError = builtin.diagnostic_click,
                    DiagnosticSignHint = builtin.diagnostic_click,
                    DiagnosticSignInfo = builtin.diagnostic_click,
                    DiagnosticSignWarn = builtin.diagnostic_click,
                    GitSignsTopdelete = builtin.gitsigns_click,
                    GitSignsUntracked = builtin.gitsigns_click,
                    GitSignsAdd = builtin.gitsigns_click,
                    GitSignsChange = builtin.gitsigns_click,
                    GitSignsChangedelete = builtin.gitsigns_click,
                    GitSignsDelete = builtin.gitsigns_click,
                    gitsigns_extmark_signs_ = builtin.gitsigns_click,
                },
            },
        }
        require("statuscol").setup(cfg)
    end,
}
return _M

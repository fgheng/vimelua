local _M = {
    {
        "neovim/nvim-lspconfig",
        enabled = true,
        -- event = { "BufReadPre", "BufNewFile" },
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            vim.lsp.set_log_level("ERROR")

            local on_init = require("lsp.utils.utils").on_init
            local on_attach = require("lsp.utils.utils").on_attach
            local capabilities = require("lsp.utils.utils").capabilities()
            local handlers = require("lsp.utils.utils").handlers()

            local lspconfig = require("lspconfig")
            local servers = require("config").servers.lsp_servers

            for _, lsp in pairs(servers) do
                if lsp ~= "jdtls" then
                    local status_ok, server_config = pcall(require, "lsp.languages." .. lsp)

                    if status_ok then
                        local opts = {
                            on_init = on_init,
                            on_attach = on_attach,
                            capabilities = capabilities,
                            handlers = handlers,
                        }

                        opts = vim.tbl_deep_extend("force", opts, server_config)
                        lspconfig[lsp].setup(opts)
                    end
                end
            end
        end,
    },

    {
        "neoclide/coc.nvim",
        enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        branch = "release",
        config = function()
            -- Some servers have issues with backup files, see #649
            vim.opt.backup = false
            vim.opt.writebackup = false

            -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
            -- delays and poor user experience
            vim.opt.updatetime = 300

            -- Always show the signcolumn, otherwise it would shift the text each time
            -- diagnostics appeared/became resolved
            vim.opt.signcolumn = "yes"

            local keyset = vim.keymap.set
            -- Autocomplete
            function _G.check_back_space()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
            end

            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
            keyset(
                "i",
                "<TAB>",
                'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
                opts
            )
            keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            keyset(
                "i",
                "<cr>",
                [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
                opts
            )

            -- Use <c-j> to trigger snippets
            keyset("i", "<M-j>", "<Plug>(coc-snippets-expand-jump)")
            -- Use <c-space> to trigger completion
            keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

            -- Use `[g` and `]g` to navigate diagnostics
            -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
            keyset("n", "<M-j>", "<Plug>(coc-diagnostic-prev)", { silent = true })
            keyset("n", "<M-k>", "<Plug>(coc-diagnostic-next)", { silent = true })

            -- Add (Neo)Vim's native statusline support
            -- NOTE: Please see `:h coc-status` for integrations with external plugins that
            -- provide custom statusline: lightline.vim, vim-airline
            vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

            -- Mappings for CoCList
            -- code actions and coc stuff
            ---@diagnostic disable-next-line: redefined-local
            local opts = { silent = true, nowait = true }
            -- Show all diagnostics
            keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
            -- Manage extensions
            keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
            -- Show commands
            keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
            -- Find symbol of current document
            keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
            -- Search workspace symbols
            keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
            -- Do default action for next item
            keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
            -- Do default action for previous item
            keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
            -- Resume latest coc list
            keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
        end,
    },

    {
        "zeioth/garbage-day.nvim",
        enabled = false,
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            -- your options here
            excluded_lsp_clients = { "null-ls", "jdtls" },
        },
    },
}

return _M

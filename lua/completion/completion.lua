vim.opt.pumheight = 20 -- 提示框显示提示条目数量
local _M = {
    {
        "saghen/blink.compat",
        enabled = false,
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = "*",
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = false,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },

    {
        "saghen/blink.cmp",
        enabled = false,
        event = { "InsertEnter", "CmdlineEnter" },

        -- use a release tag to download pre-built binaries
        version = "*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        -- optional: provides snippets for the snippet source
        dependencies = {
            --"rafamadriz/friendly-snippets",
            "hrsh7th/cmp-cmdline",
        },

        config = function()
            -- local luasnip_status_ok, luasnip = pcall(require, "luasnip")
            -- if not luasnip_status_ok then
            --     vim.notify("luasnip not found")
            -- end

            --             {
            --   accept = <function 1>,
            --   add_filetype_source = <function 2>,
            --   add_provider = <function 3>,
            --   cancel = <function 4>,
            --   get_lsp_capabilities = <function 5>,
            --   get_selected_item = <function 6>,
            --   hide = <function 7>,
            --   hide_documentation = <function 8>,
            --   hide_signature = <function 9>,
            --   is_documentation_visible = <function 10>,
            --   is_ghost_text_visible = <function 11>,
            --   is_menu_visible = <function 12>,
            --   is_signature_visible = <function 13>,
            --   is_visible = <function 14>,
            --   reload = <function 15>,
            --   scroll_documentation_down = <function 16>,
            --   scroll_documentation_up = <function 17>,
            --   select_and_accept = <function 18>,
            --   select_next = <function 19>,
            --   select_prev = <function 20>,
            --   setup = <function 21>,
            --   show = <function 22>,
            --   show_and_insert = <function 23>,
            --   show_documentation = <function 24>,
            --   show_signature = <function 25>,
            --   snippet_active = <function 26>,
            --   snippet_backward = <function 27>,
            --   snippet_forward = <function 28>
            -- }
            require("blink.cmp").setup({
                -- 'default' for mappings similar to built-in completion
                -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                -- See the full "keymap" documentation for information on defining your own keymap.
                keymap = {
                    preset = "default",

                    ["<Tab>"] = {
                        function(cmp)
                            if cmp.is_visible() then
                                return cmp.select_next()
                            else
                                return false
                            end
                        end,

                        "fallback",
                    },
                    ["<M-j>"] = {
                        function(cmp)
                            if cmp.is_visible() then
                                return cmp.select_next()
                            -- elseif luasnip_status_ok and luasnip.jumpable(1) then
                            --     luasnip.jump(1)
                            --     return true
                            else
                                return false
                            end
                        end,
                        "fallback",
                    },
                    ["<S-Tab"] = {
                        function(cmp)
                            if cmp.is_visible() then
                                return cmp.select_prev()
                            else
                                return false
                            end
                        end,
                        "fallback",
                    },
                    ["<M-k"] = {
                        function(cmp)
                            if cmp.is_visible() then
                                return cmp.select_prev()
                            -- elseif luasnip_status_ok and luasnip.jumpable(1) then
                            --     luasnip.jump(-1)
                            --     return true
                            else
                                return false
                            end
                        end,
                        "fallback",
                    },

                    ["<c-space>"] = {},
                    ["<M-h>"] = { "hide", "fallback" },
                    ["<cr>"] = {
                        function(cmp)
                            if cmp.get_selected_item() == nil then
                                return false
                            end
                            if cmp.snippet_active() then
                                return cmp.accept()
                            else
                                return cmp.select_and_accept()
                            end
                        end,
                        "fallback",
                    },

                    ["<c-d>"] = { "scroll_documentation_down" },
                    ["<c-u>"] = { "scroll_documentation_up" },
                    -- ["<M-J>"] = {"scroll_documentation_down"},
                    -- ["<M-K>"] = {"scroll_documentation_up"},
                    -- ["<M-j>"] = {"snippet_forward"},
                    -- ["<M-k>"] = {"snippet_backward"}
                },

                appearance = {
                    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                    -- Useful for when your theme doesn't support blink.cmp
                    -- Will be removed in a future release
                    use_nvim_cmp_as_default = true,
                    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = "mono",
                },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    -- default = { "lsp", "path", "snippets", "buffer" },
                    default = function(ctx)
                        local success, node = pcall(vim.treesitter.get_node)
                        if vim.bo.filetype == "lua" then
                            return { "lsp", "path" }
                        elseif
                            success
                            and node
                            and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
                        then
                            return { "buffer" }
                        else
                            return { "lsp", "path", "snippets", "buffer" }
                        end
                    end,
                    cmdline = { "cmdline", "path", "buffer" },
                    providers = {
                        buffer = {
                            opts = {
                                -- get all buffers, even ones like neo-tree
                                -- get_bufnrs = vim.api.nvim_list_bufs
                                -- or (recommended) filter to only "normal" buffers
                                get_bufnrs = function()
                                    return vim.tbl_filter(function(bufnr)
                                        return vim.bo[bufnr].buftype == ""
                                    end, vim.api.nvim_list_bufs())
                                end,
                            },
                        },
                        cmdline = {
                            name = "cmdline",
                            module = "blink.compat.source",
                        },
                    },
                },

                -- Use a preset for snippets, check the snippets documentation for more information
                snippets = { preset = "luasnip" }, -- "default" | "luasnip" | "mini_snippets" },

                -- Experimental signature help support
                signature = {
                    enabled = true,
                    window = {
                        border = require("config").ui.float_ui_win.border,
                    },
                },

                completion = {
                    -- 'prefix' will fuzzy match on the text before the cursor
                    -- 'full' will fuzzy match on the text before *and* after the cursor
                    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
                    keyword = { range = "prefix" },
                    menu = {
                        -- Don't automatically show the completion menu
                        auto_show = true,

                        -- nvim-cmp style menu
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label", "label_description", gap = 1 },
                                { "kind" },
                                { "source_name" },
                            },
                            components = {
                                item_idx = {
                                    text = function(ctx)
                                        return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
                                    end,
                                    highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
                                },
                                source_name = {
                                    width = { max = 30 },
                                    text = function(ctx)
                                        return "[" .. ctx.source_name .. "]"
                                    end,
                                    highlight = "BlinkCmpSource",
                                },
                            },
                        },
                        border = require("config").ui.float_ui_win.border,
                    },
                    documentation = {
                        auto_show = true,
                        window = {
                            border = require("config").ui.float_ui_win.border,
                        },
                    },

                    -- Don't select by default, auto insert on selection
                    -- list = { selection = { preselect = false, auto_insert = true } },
                    -- or set either per mode via a function
                    list = {
                        cycle = {
                            from_top = true,
                        },
                        selection = {
                            -- preselect = function(ctx)
                            --     return ctx.mode ~= "cmdline"
                            -- end,
                            preselect = false,
                            auto_insert = true,
                        },
                        -- selection = function(cmp)
                        --     cmp.select_prev({ auto_insert = false })
                        -- end,
                    },

                    accept = {},
                },
            })
        end,
        opts_extend = { "sources.default" },
    },
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            ----------------------------------------------------------------------
            --                         snippets config                          --
            ----------------------------------------------------------------------
            local luasnip_status_ok, luasnip = pcall(require, "luasnip")
            if not luasnip_status_ok then
                vim.notify("luasnip not found")
            end

            local cmp = require("cmp")

            ----------------------------------------------------------------------
            --                              config                              --
            ----------------------------------------------------------------------
            -- local icons = require("utils.icons").kinds
            local api = vim.api
            cmp.setup({
                snippet = {
                    expand = function(args)
                        if luasnip_status_ok then
                            luasnip.lsp_expand(args.body)
                        end
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<c-d>"] = cmp.mapping.scroll_docs(4),
                    ["<c-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<M-J>"] = cmp.mapping.scroll_docs(4),
                    ["<M-K>"] = cmp.mapping.scroll_docs(-4),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<M-h>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        else
                            fallback()
                        end
                    end, { "i", "s", "c" }),
                    ["<M-j>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip_status_ok and luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<M-k>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip_status_ok and luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- elseif luasnip_status_ok and luasnip.jumpable(1) then
                        --     luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        -- elseif luasnip_status_ok and luasnip.jumpable(-1) then
                        --     luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = {
                    -- 越大越后
                    -- { name = "copilot", group_index = 2 },
                    -- {name = "fittencode", group_index = 2},
                    { name = "luasnip", group_index = 2 },
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "nvim_lsp_signature_help", group_index = 2 },
                    { name = "path", group_index = 2 },
                    { name = "nerdfonts" },
                    {
                        name = "buffer",
                        group_index = 3,
                        option = {
                            get_bufnrs = function()
                                return api.nvim_list_bufs()
                            end,
                        },
                    },
                },

                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    max_width = 0,
                    format = function(entry, vim_item)
                        local max_len = 50 -- 限制提示框的宽度
                        if string.len(vim_item.abbr) > max_len then
                            vim_item.abbr = string.sub(vim_item.abbr, 1, max_len - 2) .. "···"
                        else
                            vim_item.abbr = string.format("%-" .. max_len .. "s", vim_item.abbr)
                        end

                        -- vim_item.kind = string.format("%s", icons[vim_item.kind])
                        -- vim_item.kind = ""

                        vim_item.menu = ({
                            buffer = "[Buf]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            path = "[Path]",
                        })[entry.source.name]

                        return vim_item
                    end,
                },

                sorting = {
                    priority_weight = 2,
                    comparators = {
                        -- require("copilot_cmp.comparators").prioritize,

                        -- Below is the default comparitor list and order for nvim-cmp
                        cmp.config.compare.offset,
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },

                view = {
                    entries = {
                        -- can be "custom", "wildmenu" or "native"
                        name = "custom",
                        -- 在底部的时候，提示内容从下到上
                        selection_order = "near_cursor",
                    },
                },

                experimental = {
                    ghost_text = false,
                },

                -- window = {
                --     completion = cmp.config.window.bordered(),
                --     documentation = cmp.config.window.bordered(),
                -- },
                window = {
                    completion = {
                        border = require("config").ui.float_ui_win.border,
                        winhighlight = "FloatBorder:FloatBorder,CursorLine:CursorLine",
                    },
                    documentation = {
                        max_width = 50,
                        border = require("config").ui.float_ui_win.border,
                        winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    },
                },

                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "buffer" } }),
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
            })
        end,
    },
}

return _M

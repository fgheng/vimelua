vim.opt.pumheight = 20 -- 提示框显示提示条目数量
local _M = {
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
            local icons = require("utils.icons").kinds
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
                        elseif luasnip_status_ok and luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip_status_ok and luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = {
                    -- 越大越后
                    -- { name = "copilot", group_index = 2 },
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "nvim_lsp_signature_help", group_index = 2 },
                    { name = "luasnip", group_index = 2 },
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

                        vim_item.kind = string.format("%s", icons[vim_item.kind])

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
                        --border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                        border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
                        --border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
                        winhighlight = "FloatBorder:FloatBorder,CursorLine:CursorLine",
                    },
                    documentation = {
                        max_width = 50,
                        --border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                        border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
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

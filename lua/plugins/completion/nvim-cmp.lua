local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    vim.notify('cmp not found')
    return
end

----------------------------------------------------------------------
--                         snippets config                          --
----------------------------------------------------------------------
local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_status_ok then
    vim.notify('luasnip not found')
    return
end

-- require("luasnip.loaders.from_snipmate").lazy_load()
require('luasnip.loaders.from_vscode').lazy_load() -- load freindly-snippets
require('luasnip.loaders.from_vscode').load({ paths = { -- load custom snippets
    require('config').snippet_path
} })

----------------------------------------------------------------------
--                              config                              --
----------------------------------------------------------------------
local kind_icons = require('plugins.theme.icons').kind
local api = vim.api
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        -- ['<c-k>'] = cmp.mapping.select_prev_item(),
        -- ['<c-j>'] = cmp.mapping.select_next_item(),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<M-u>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<M-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<M-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    sources = {
        -- 越大越后
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'nvim_lsp_signature_help', group_index = 1 },
        { name = 'luasnip', group_index = 1 },
        { name = 'copilot', group_index = 2 },
        { name = 'path', group_index = 2 },
        { name = 'buffer', group_index = 2,
            option = {
                get_bufnrs = function()
                    -- 全部buffer
                    return api.nvim_list_bufs()
                    -- 限定大小
                    -- local buf = api.nvim_get_current_buf()
                    -- local byte_size = api.nvim_buf_get_offset(buf, api.nvim_buf_line_count(buf))
                    -- if byte_size > 1024 * 1024 then -- 1 Megabyte max
                    --     return {}
                    -- end
                    -- return { buf }
                    -- 可视buffer
                    -- local bufs = {}
                    -- for _, win in ipairs(api.nvim_list_wins()) do
                    --     bufs[api.nvim_win_get_buf(win)] = true
                    -- end
                    -- return vim.tbl_keys(bufs)
                end
            }
        },
    },

    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        max_width = 0,
        format = function(entry, vim_item)
            local max_len = 35 -- 限制提示框的宽度
            if string.len(vim_item.abbr) > max_len then
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_len - 2) .. "···"
            else
                vim_item.abbr = string.format('%-' .. max_len .. 's', vim_item.abbr)
            end

            vim_item.kind = string.format('%s', kind_icons[vim_item.kind])

            vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                path = '[Path]',
                -- copilot = '[Copilot]'
            })[entry.source.name]

            return vim_item
        end,
    },

    view = {
        entries = {
            -- can be "custom", "wildmenu" or "native"
            name = 'custom',
            -- 在底部的时候，提示内容从下到上
            -- selection_order = 'near_cursor',
        },
    },

    experimental = {
        ghost_text = false,
        native_menu = false,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        { { name = 'buffer' } }
    )
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        { { name = 'path' } },
        { { name = 'cmdline' } }
    )
})

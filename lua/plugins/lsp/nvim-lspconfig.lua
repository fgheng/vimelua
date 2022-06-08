local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    vim.notify('lspconfig not found')
    return
end

----------------------------------------------------------------------
--                        nvim lsp installer                        --
----------------------------------------------------------------------
local server_names = require('config').lsp_servers.names
local server_config = require('config').lsp_servers.config
local icons_signs = require('plugins.theme.icons').signs
local install_status_ok, nvim_lsp_install = pcall(require, 'nvim-lsp-installer')
if install_status_ok then
    nvim_lsp_install.setup({
        -- ensure_installed = servers_name,
        automatic_installation = true,
        ui = {
            icons = {
                server_installed = icons_signs.check,
                server_pending = icons_signs.arrow_right,
                server_uninstalled = icons_signs.unpack,
            }
        },
        keymaps = {
            toggle_server_expand = '<CR>',
            install_server = 'i',
            update_server = 'u',
            check_server_version = 'c',
            update_all_servers = 'U',
            check_outdated_servers = 'C',
            uninstall_server = 'X',
        },
        install_root_dir = vim.fn.stdpath('data') .. '/lsp_servers',
        pip = {
            install_args = {},
        },
    })
else
    vim.notify('nvim-lsp-installer not found')
end

----------------------------------------------------------------------
--                            lspconfig                             --
----------------------------------------------------------------------
local aerial_status_ok, aerial = pcall(require, 'aerial')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- capabilities.offsetEncoding = 'utf-8' -- 以前不需要的，最近要加这个了
-- 解决clangd warning: multiple different client offset_encodings detected for buffer, this is not supported yet
for _, name in ipairs(server_names) do
    local conf = {}
    if server_config[name] ~= nil then
        conf = vim.tbl_deep_extend('force', conf, server_config[name])
        if server_config[name]['offset_encodings'] ~= nil then
            capabilities.offsetEncoding = server_config[name]['offset_encodings']
        end
    end

    local opts = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            if aerial_status_ok then
                aerial.on_attach(client, bufnr)
            end
        end,
        on_init = function (client)
            -- FIX: 这里有时候提示error occured while processing CursorMoved autocommands for *
            vim.api.nvim_exec(
                [[
                    augroup lsp_document_highlight
                        autocmd! * <buffer>
                        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                    augroup END
                ]],
                false
            )
        end

    }

    opts = vim.tbl_deep_extend('force', opts, conf)

    lspconfig[name].setup(opts)
end

----------------------------------------------------------------------
--                             key map                              --
----------------------------------------------------------------------
local opts = { silent = true, noremap = true }

vim.keymap.set('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
vim.keymap.set('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
vim.keymap.set('n', '<m-j>', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
vim.keymap.set('n', '<m-k>', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = false})<cr>', opts)
vim.keymap.set('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)
-- vim.api.nvim_create_user_command("format", vim.lsp.buf.format, {async = false})

-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
-- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
-- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
-- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
-- vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
-- vim.keymap.set('n', '<m-j>', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
-- vim.keymap.set('n', '<m-k>', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
-- vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

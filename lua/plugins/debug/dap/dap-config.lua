local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    vim.notify("dap not found")
    return
end

local api = vim.api
local fn = vim.fn
----------------------------------------------------------------------
--                              icons                               --
----------------------------------------------------------------------
local icons = require("ui.icons")
local dap_breakpoint = {
    error = {
        text = icons.debug_breakpoint_error,
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
    },
    rejected = {
        text = icons.debug_breakpoint_reject,
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    },
    stopped = {
        text = icons.debug_breakpoint_stop,
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
    },
}
fn.sign_define("DapBreakpoint", dap_breakpoint.error)
fn.sign_define("DapStopped", dap_breakpoint.stopped)
fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

----------------------------------------------------------------------
--                            ui config                             --
----------------------------------------------------------------------
local vir_status_ok, _ = pcall(require, "nvim-dap-virtual-text")
local dapui_status_ok, dapui = pcall(require, "dapui")
local debug_open = function()
    if dapui_status_ok then
        dapui.open()
    end
    if vir_status_ok then
        api.nvim_command("DapVirtualTextEnable")
    end
end
local debug_close = function()
    dap.repl.close()
    if dapui_status_ok then
        dapui.close()
    end
    if vir_status_ok then
        api.nvim_command("DapVirtualTextDisable")
    end
end
dap.defaults.fallback.terminal_win_cmd = "30vsplit new" -- this will be overrided by dapui
dap.set_log_level("DEBUG")

local close_terminal = function()
    local bufnr = fn.bufnr("[dap-terminal] Launch File")
    if bufnr ~= -1 then
        api.nvim_buf_delete(bufnr, { force = true })
    end
end

----------------------------------------------------------------------
--                              events                              --
----------------------------------------------------------------------
-- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook
local keymap_restore = {}

dap.listeners.after["event_initialized"]["me"] = function()
    debug_open()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, "n")
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, "n", "K")
            end
        end
        api.nvim_buf_set_keymap(buf, "n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
    end
end

dap.listeners.after["event_terminated"]["me"] = function()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
    end
    keymap_restore = {}
    debug_close()
    close_terminal()
end

dap.listeners.before["event_exited"]["me"] = function()
    debug_close()
    close_terminal()
end

dap.listeners.before["disconnect"]["me"] = function()
    debug_close()
    close_terminal()
end

-- dap.listeners.after['disconnect']['me'] = function()
--     close_repl()
-- end

----------------------------------------------------------------------
--                         adapters config                          --
----------------------------------------------------------------------
local debug_config = require("config").debug_servers
local debug_server_names = debug_config.names
local debug_server_config = debug_config.config

for k_name, v_name in pairs(debug_server_names) do
    if debug_server_config[k_name] ~= nil then
        dap.adapters[v_name] = debug_server_config[k_name]["adapter"]
        dap.configurations[k_name] = debug_server_config[k_name]["config"]
    end
end

----------------------------------------------------------------------
--                              keymap                              --
----------------------------------------------------------------------
local opts = { silent = true, noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<F5>", '<cmd>lua require("dap").toggle_breakpoint()<cr>', opts)
keymap("n", "<F6>", '<cmd>lua require("dap").continue()<cr>', opts)
keymap("n", "<F7>", '<cmd>lua require("dap").terminate()<cr>', opts)
-- keymap('n', '<F10>', '<cmd>lua require("dap").step_into()()<cr>', opts)
-- keymap('n', '<F8>', '<cmd>lua require("dap").step_out()()<cr>', opts)
-- keymap('n', '<F7>', '<cmd>lua require("dap").step_over()()<cr>', opts)
-- keymap('n', '<F6>', '<cmd>lua require("dap").eval()()<cr>', opts)

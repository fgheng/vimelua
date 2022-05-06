local status_ok, lsp_status = pcall(require, "lsp-status")
if not status_ok then
    vim.notify("lsp-status not found")
    return
end

lsp_status.config({
    select_symbol = function(cursor_pos, symbol)
        if symbol.valueRange then
            local value_range = {
                ["start"] = {
                    character = 0,
                    line = vim.fn.byte2line(symbol.valueRange[1]),
                },
                ["end"] = {
                    character = 0,
                    line = vim.fn.byte2line(symbol.valueRange[2]),
                },
            }

            return require("lsp-status.util").in_range(cursor_pos, value_range)
        end
    end,
    current_function = true,
    show_filename = true,
    indicator_errors = "E",
    indicator_warnings = "W",
    indicator_info = "i",
    indicator_hint = "?",
    indicator_ok = "Ok",
})

lsp_status.register_progress()

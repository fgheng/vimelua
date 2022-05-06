-- local function symbol_info()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
--     if not clangd_client or not clangd_client.supports_method("textDocument/symbolInfo") then
--         return vim.notify("Clangd client not found", vim.log.levels.ERROR)
--     end
--     local win = vim.api.nvim_get_current_win()
--     local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
--     clangd_client.request("textDocument/symbolInfo", params, function(err, res)
--         if err or #res == 0 then
--             -- Clangd always returns an error, there is not reason to parse it
--             return
--         end
--         local container = string.format("container: %s", res[1].containerName) ---@type string
--         local name = string.format("name: %s", res[1].name) ---@type string
--         vim.lsp.util.open_floating_preview({ name, container }, "", {
--             height = 2,
--             width = math.max(string.len(name), string.len(container)),
--             focusable = false,
--             focus = false,
--             border = "single",
--             title = "Symbol Info",
--         })
--     end, bufnr)
-- end
--
-- local function switch_source_header_splitcmd(bufnr, splitcmd)
--     bufnr = require("lspconfig").util.validate_bufnr(bufnr)
--     local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
--     local params = { uri = vim.uri_from_bufnr(bufnr) }
--     if clangd_client then
--         clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
--             if err then
--                 error(tostring(err))
--             end
--             if not result then
--                 vim.notify("Corresponding file can’t be determined", vim.log.levels.ERROR, { title = "LSP Error!" })
--                 return
--             end
--             vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
--         end)
--     else
--         vim.notify(
--             "Method textDocument/switchSourceHeader is not supported by any active server on this buffer",
--             vim.log.levels.ERROR,
--             { title = "LSP Error!" }
--         )
--     end
-- end

return {
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
        -- "--malloc-trim=true",
        "--background-index",
        -- "--completion-style=detailed",
        -- '--cross-file-rename=true',
        "--header-insertion=iwyu",
        "--pch-storage=memory",
        -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
        "--function-arg-placeholders=false",
        -- "--log=verbose",
        "--ranking-model=decision_forest",
        -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
        "--header-insertion-decorators",
        "--pch-storage=memory",
        "-j=12",
        -- "--compile-commands-dir=".. vim.fn.getcwd(),
        -- -- "--pretty",
        -- "--all-scopes-completion",
        --     "--clang-tidy",
        --     -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
        -- "--query-driver=" .. get_binary_path_list({ "clang++", "clang", "gcc", "g++" }),
        --     "--enable-config",
        -- "--limit-references=10000",
        --     "--limit-results=350",
    },
    single_file_support = true,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "cc", "cppm" },
    inlay_hints = {
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "<- ",
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "Comment",
        -- The highlight group priority for extmark
        priority = 100,
    },
    formatter = "clang-format",
    -- commands = {
    --     ClangdSwitchSourceHeader = {
    --         function()
    --             switch_source_header_splitcmd(0, "edit")
    --         end,
    --         description = "Open source/header in current buffer",
    --     },
    --     ClangdSwitchSourceHeaderVSplit = {
    --         function()
    --             switch_source_header_splitcmd(0, "vsplit")
    --         end,
    --         description = "Open source/header in a new vsplit",
    --     },
    --     ClangdSwitchSourceHeaderSplit = {
    --         function()
    --             switch_source_header_splitcmd(0, "split")
    --         end,
    --         description = "Open source/header in a new split",
    --     },
    --     ClangdShowSymbolInfo = {
    --         function()
    --             symbol_info()
    --         end,
    --         description = "Show symbol info",
    --     },
    -- },
}

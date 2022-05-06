local _M = {
    "Bekaboo/dropbar.nvim",
    enabled = true,
    -- event = { "BufRead", "BufNewFile" },
    event = { "UiEnter" },
    config = function()
        local dropbar = require("dropbar")
        local utils = require("dropbar.utils")
        local close = function()
            local menu = utils.menu.get_current()
            while menu and menu.prev_menu do
                if menu.prev_menu then
                    menu = menu.prev_menu
                end
            end
            if menu then
                menu:close()
            end
        end
        dropbar.setup({
            icons = {
                -- kinds = { symbols = {}, use_devicons = false },
                ui = { bar = { separator = " > " } },
            },
            keymaps = {
                -- Close the dropbar entirely with <esc> and q.
            },
            bar = {
                enable = function(buf, win)
                    return not vim.api.nvim_win_get_config(win).zindex
                        and vim.bo[buf].buftype == ""
                        and vim.api.nvim_buf_get_name(buf) ~= ""
                        and not vim.wo[win].diff
                        and vim.bo[buf].filetype ~= "toggleterm"
                end,
                hover = true,
            },
            menu = {
                quick_navigation = false,
                preview = false,
                hover = true,
                keymaps = {
                    ["<cr>"] = function()
                        local menu = utils.menu.get_current()
                        if not menu then
                            return
                        end
                        local cursor = vim.api.nvim_win_get_cursor(menu.win)
                        local entry = menu.entries[cursor[1]]
                        local component = entry:first_clickable(entry.padding.left + entry.components[1]:bytewidth())
                        if component then
                            menu:click_on(component, nil, 1, "l")
                        end
                    end,
                    ["h"] = function()
                        local menu = utils.menu.get_current()
                        if not menu then
                            return
                        end
                        menu:close()
                        -- require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count)
                        require("dropbar.api").pick()
                    end,
                    ["l"] = function()
                        local menu = require("dropbar.api").get_current_dropbar_menu()
                        if not menu then
                            return
                        end
                        local cursor = vim.api.nvim_win_get_cursor(menu.win)
                        local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
                        if component then
                            menu:click_on(component, nil, 1, "l")
                        end
                    end,
                    ["<CR>"] = function()
                        -- local menu = utils.menu.get_current()
                        -- if not menu then
                        --     return
                        -- else
                        --     menu:click_at()
                        --     utils.menu.exec("close")
                        --     utils.bar.exec("update_current_context_hl")
                        -- end
                        local menu = utils.menu.get_current()
                        if not menu then
                            return
                        end
                        local cursor = vim.api.nvim_win_get_cursor(menu.win)
                        local entry = menu.entries[cursor[1]]
                        local component = entry:first_clickable(entry.padding.left + entry.components[1]:bytewidth())
                        if component then
                            menu:click_on(component, nil, 1, "l")
                        end
                    end,
                    ["q"] = close,
                    ["<esc>"] = close,
                },

                win_configs = {
                    border = require("config").ui.float_ui_win.border,

                },
            },
        })
    end,
    keys = {
        { "<M-->", "<cmd>lua require('dropbar.api').pick()<cr>", desc = "pick dropbar" },
    },
}
return _M

local status_ok, dapui = pcall(require, 'dapui')
if not status_ok then
    vim.notify('nvim-dap-ui not found')
    return
end

dapui.setup({
    icons = { expanded = '▾', collapsed = '▸' },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { 'o', '<2-LeftMouse>' },
        open = { 'O', '<CR>' },
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
    },
    layouts = {
        {
            elements = {
                -- Provide as ID strings or tables with 'id' and 'size' keys
                { id = 'breakpoints', size = 0.15 },
                { id = 'watches', size = 0.15 },
                { id = 'stacks', size = 0.35 },
                { id = 'scopes', size = 0.35 }, -- Can be float or integer > 1
            },
            size = 40,
            position = 'left', -- Can be 'left', 'right', 'top', 'bottom'
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom",
        }
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    }
})


-- local opts = { silent = true, noremap = true }
-- local keymap = vim.api.nvim_set_keymap
--
-- keymap('n', '<f4>', '<cmd>lua require('dapui').toggle()<cr>', opts)

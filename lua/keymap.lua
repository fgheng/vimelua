local map = vim.keymap
local opts = { noremap = true, silent = true }

-- 窗口移动
map.set('n', '<c-h>', '<c-w>h', opts)
map.set('n', '<c-j>', '<c-w>j', opts)
map.set('n', '<c-k>', '<c-w>k', opts)
map.set('n', '<c-l>', '<c-w>l', opts)
map.set('t', '<c-h>', '<c-\\><c-n><c-w>h', opts)
map.set('t', '<c-j>', '<c-\\><c-n><c-w>j', opts)
map.set('t', '<c-k>', '<c-\\><c-n><c-w>k', opts)
map.set('t', '<c-l>', '<c-\\><c-n><c-w>l', opts)

-- 窗口分割
map.set('n', '<c-w>k', '<cmd>abo split<cr>', opts)
map.set('n', '<c-w>h', '<cmd>abo vsplit<cr>', opts)
map.set('n', '<c-w>j', '<cmd>rightbelow split<cr>', opts)
map.set('n', '<c-w>l', '<cmd>rightbelow vsplit<cr>', opts)

-- 窗口关闭
map.set('n', 'Q', '<nop>', opts)
map.set('n', 'Q', 'q', opts)
map.set('n', 'q', '<cmd>close<cr>', opts)
-- map('n', '<m-q>', '<cmd>close<cr>')

-- tab 移动
map.set('n', '<m-L>', '<cmd>tabnext<cr>', opts)
map.set('n', '<m-H>', '<cmd>tabpre<cr>', opts)

-- tab新建
map.set('n', '<leader>tn', '<cmd>tabnew<cr>', opts)

-- esc
map.set('i', 'jk', [[<esc>]])

-- 保存
-- map('n', '<space><space>', '<cmd>w<cr>', opts)

-- 搜索颜色
map.set('n', '<BackSpace>', ':nohl<cr>', opts)

map.set('n', '>>', '>>_', opts)
map.set('n', '<<', '<<_', opts)

-- terminal
map.set('t', 'jk', [[<c-\><c-n>]])
map.set('t', '<esc>', [[<c-\><c-n>]])
map.set('n', '<leader>tt', '<cmd>terminal<cr>', opts)

-- 移动
map.set('n', 'j', 'gj', opts)
map.set('n', 'k', 'gk', opts)
map.set('v', 'j', 'gj', opts)
map.set('v', 'k', 'gk', opts)

map.set('i', '<m-o>', '<esc>o')
map.set('i', '<m-O>', '<esc>O')
map.set('i', '<m-a>', '<End>')
map.set('i', '<m-i>', '<esc>^i')

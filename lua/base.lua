local g = vim.g
local opt = vim.o
local cmd = vim.cmd
-- local api = vim.api

-- 不要搜索相应程序路径，直接使用自定义路径，启动更快
-- g.loaded_python_provider = 0
-- g.python3_host_prog = '/home/forever/Software/anaconda3/bin/python'
-- g.node_host_prog = '/usr/bin/node'

-- 取消一些内置插件
local disabled_built_ins = {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'spellfile_plugin',
    'matchit',
    'matchparen',
    'man',
    'tutor_mode_plugin',
    'remote_plugins',
    'shada_plugin',
    'filetype',
}

for _, plugin_name in pairs(disabled_built_ins) do
    g['loaded_' .. plugin_name] = 1
end

opt.ignorecase = true
opt.smartcase = true
opt.clipboard = 'unnamedplus'
opt.title = true
opt.titlestring = '%F'
opt.colorcolumn = 80
opt.cursorline = true
opt.smartindent = true
opt.autoindent = true
opt.linebreak = true -- 换行
opt.splitright = true -- 右侧分割
-- o.spell = true
opt.spelllang = 'en_us'
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true -- >> 的时候自动对齐
opt.list = true
-- o.listchars = 'space:⋅,tab:→ ,eol:¬,nbsp:⣿,extends:»,precedes:«,trail:·' -- space:␣
opt.listchars = 'tab:→ ,eol:¬,nbsp:⣿,extends:»,precedes:«,trail:·' -- space:␣
opt.fillchars = 'eob: ' -- Hide
opt.whichwrap = opt.whichwrap .. 'h,l,<,>,[,]' -- 使用hl可以继续移动到下一行或者上一行
opt.pumheight = 20 -- 提示框显示提示条目数量
opt.wildmode = 'longest:full,full'
opt.termguicolors = true
opt.winblend = 20 -- 浮动窗口透明度设置
opt.foldenable = false
opt.hidden = true
opt.showmode = false
opt.showmatch = true
opt.signcolumn = 'yes:2' -- 总是显示符号列
opt.updatetime = 100
opt.completeopt = 'menuone,noselect,noinsert'
opt.shortmess = opt.shortmess .. 'c' -- Shut off completion messages
opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
opt.laststatus = 3 -- 开启全局状态栏
-- opt.winbar = '%f'

cmd [[
    augroup vimeGroup_base
        au!
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | exe "normal! zz" | endif
    augroup end
]]

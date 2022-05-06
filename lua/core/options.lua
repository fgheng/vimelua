local g = vim.g
local opt = vim.o

local config = require("config")
if config.node_path ~= "" then
    g.node_host_prog = config.node_path
end

if config.python_path ~= "" then
    g.python3_host_prog = config.python_path
end

-- uncomment while using packer.lua
--[[ local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit", "matchparen", "man",
	"tutor_mode_plugin",
	"remote_plugins",
	"shada_plugin",
	"filetype",
	"syntax",
	"ftplugin",
	"ftindent",
}

for _, plugin_name in pairs(disabled_built_ins) do
	g["loaded_" .. plugin_name] = 1
end ]]

-- opt.writeany = true
opt.ignorecase = true
opt.smartcase = true
opt.title = true
opt.cursorline = true
opt.smartindent = true
opt.autoindent = true
opt.linebreak = true -- 换行
opt.splitright = true -- 右侧分割
opt.splitbelow = true
opt.termguicolors = true
opt.hidden = true
opt.showmatch = true
opt.number = true
-- opt.relativenumber = true
opt.smarttab = true
opt.expandtab = true
opt.shiftround = true -- >> 的时候自动对齐
opt.list = true
opt.noswapfile = true
opt.foldenable = false
opt.showmode = false
opt.backup = false
opt.writebackup = false
opt.confirm = false
-- opt.wrap = false

-- opt.clipboard = "unnamedplus"
-- opt.viewoptions = "cursor,folds,curdir,slash,unix"
opt.titlestring = "%F"
opt.spelllang = "en_us"
opt.mouse = "a"
-- opt.foldmethod = "indent"
-- o.listchars = 'space:⋅,tab:→ ,eol:¬,nbsp:⣿,extends:»,precedes:«,trail:·' -- space:␣
-- opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
opt.listchars = "tab:→ ,eol:↴,nbsp:⣿,extends:»,precedes:«,trail:·" --,space:␣'
opt.fillchars = "eob: " -- Hide
opt.whichwrap = opt.whichwrap .. "h,l,<,>,[,]" -- 使用hl可以继续移动到下一行或者上一行
opt.wildmode = "longest:full,full"
opt.signcolumn = "yes:1" -- 总是显示符号列
opt.completeopt = "menuone,noselect,noinsert"
opt.shortmess = opt.shortmess .. "c" -- Shut off completion messages
opt.guicursor = "n-v-c-sm:blinkon01,i-ci-ve:ver25-blinkon01,r-cr-o:hor20"
-- opt.fillchars = "vert:⎹,vertleft:⎹,vertright:⎹,horiz:⸻,horizup:⸻,horizdown:⸻,fold: ,foldopen:│,foldclose:│,foldsep:│,eob:,msgsep:"

-- opt.colorcolumn = 80
opt.cmdheight = 1
opt.pumheight = 20 -- 提示框显示提示条目数量
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.winblend = 30 -- 浮动窗口透明度设置
opt.updatetime = 100
opt.laststatus = 3 -- 开启全局状态栏
-- opt.timeoutlen = 100 -- Time in milliseconds to wait for a mapped sequence to complete.

vim.defer_fn(function()
    -- opt.undofile = true
end, 300)

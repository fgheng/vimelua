local g = vim.g
local opt = vim.o

local config = require("config")
if config.node_path ~= "" then
    g.node_host_prog = config.node_path
end

if config.python_path ~= "" then
    g.python3_host_prog = config.python_path
end

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
opt.smarttab = true
opt.expandtab = true
opt.shiftround = true -- >> 的时候自动对齐
opt.list = true
opt.showmode = false
opt.backup = false
opt.writebackup = false
opt.confirm = false
opt.equalalways = false

opt.titlestring = "%F"
opt.spelllang = "en_us"
opt.mouse = "a"
opt.listchars = "tab:→ ,nbsp:⣿,extends:»,precedes:«,trail:·" --,space:␣'eol:↴,
opt.whichwrap = opt.whichwrap .. "h,l,<,>,[,]" -- 使用hl可以继续移动到下一行或者上一行
opt.wildmode = "longest:full,full"
opt.completeopt = "menuone,noselect,noinsert"
opt.shortmess = opt.shortmess .. "c" -- Shut off completion messages
opt.guicursor = "n-v-c-sm:blinkon01,i-ci-ve:ver25-blinkon01,r-cr-o:hor20"
-- opt.splitkeep = "screen"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

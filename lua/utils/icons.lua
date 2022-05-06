local _M = {}

-- _M.debug = {
--     debug_bug = "",
--     debug_into = "",
--     debug_out = "",
--     debug_over = "",
--     debug_breakpoint = "",
--     debug_breakpoint_reject = "⚫", --
--     debug_breakpoint_error = "🛑", -- 🔴
--     debug_breakpoint_stop = "", -- 🟢
-- }

_M.git = {
    add = "+",
    modify = "~",
    remove = "-",
    ignore = "◌",
    rename = "r",
    diff = "",
    repo = "",
    branch = "",
    delete = "",
    unstage = "✗",
    stage = "✓",
    unmerg = "",
    untrack = "?",
    change = "~",
    confict = "",
}

_M.spinners = {
    moon = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
    eyes = { "◡◡", "⊙⊙", "◠◠", "⊙⊙" },
    wedges = { "◴", "◷", "◶", "◵" },
    wedges2 = { "○", "◔", "◗", "◕", "●" },
    horizontal_bar = { "▉", "▊", "▋", "▌", "▍", "▎", " ", "▏", "▎", "▍", "▌", "▋", "▊", "▉" },
    double_point = { "▹▹", "▸▹", "▹▸", "▸▸", "▹▸" },
    diamonds = { "◇", "◈", "◆", "◈", "◇" },
    running_man = { "ﰌ", "省" },
    quarter_circles = { "◜ ", " ◝", " ◞", "◟ " },
    half_circles = { "◐", "◓", "◑", "◒" },
    equals = { "≔", "≒", "≓", "≕", "≓", "≒", "≔" },
    circles = { "⊶", "⊷" },
    smilers = { "☺", "☻" },
    vert_drop = { "䷀", "䷪", "䷍", "䷈", "䷉", "䷌", "䷫" },
    arrows = { "←", "↖", "↑", "↗", "→", "↘", "↓", "↙" },
    quadrants = { "▖", "▘", "▝", "▗" },
    dots = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
}

_M.icons = {
    dot = "•",
    little_square = "◻",
    circle = "●",
    hellow_circle = "◉",
    square = "■",
    arrow_right = "➜", -- "",
    arrow_left = "➜",
    arrow_up = "↑",
    arrow_down = "↓",
    trigangle_right = "▶",
    trigangle_down = "▼",
    trigangle_up = "▲",
    trigangle_left = "◀",
    flash = "☻", -- 
    double_arrow_right = "»",
    vertical_bar = "│",
    search = "◉",
    telescope = "",
}

_M.kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = "󱄽 ",
    String = " ",
    Struct = "󰆼 ",
    Supermaven = " ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
}

_M.symbols = {
    error = "■",
    warning = "◉", -- ▲
    info = "●",
    hint = "○",
    fold_open = "",
    fold_close = "",
    folder_open = "", -- 
    folder_close = "", -- 
    folder_empty = "◇", -- 
    select_arrow = "•",
}

return _M

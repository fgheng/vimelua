local warehouse = {
    spinners = {
        moon = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
        eyes = { "◡◡", "⊙⊙", "◠◠", "⊙⊙" },
        wedges = { "◴", "◷", "◶", "◵" },
        wedges2 = { "○", "◔", "◗", "◕", "●" },
        horizontal_bar = { "▉", "▊", "▋", "▌", "▍", "▎", " ", "▏", "▎", "▍", "▌", "▋", "▊", "▉", },
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
        dots = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        dots2 = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        dots3 = { "⠄", "⠆", "⠇", "⠋", "⠙", "⠸", "⠰", "⠠", "⠰", "⠸", "⠙", "⠋", "⠇", "⠆" },
        dots4 = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        dots5 = { "⠋", "⠙", "⠚", "⠒", "⠂", "⠂", "⠒", "⠲", "⠴", "⠦", "⠖", "⠒", "⠐", "⠐", "⠒", "⠓", "⠋", },
        dots6 = { "⠁", "⠉", "⠙", "⠚", "⠒", "⠂", "⠂", "⠒", "⠲", "⠴", "⠤", "⠄", "⠄", "⠤", "⠴", "⠲", "⠒", "⠂", "⠂", "⠒", "⠚", "⠙", "⠉", "⠁", },
        dots7 = { "⠈", "⠉", "⠋", "⠓", "⠒", "⠐", "⠐", "⠒", "⠖", "⠦", "⠤", "⠠", "⠠", "⠤", "⠦", "⠖", "⠒", "⠐", "⠐", "⠒", "⠓", "⠋", "⠉", "⠈", },
        dots8 = { "⠁", "⠁", "⠉", "⠙", "⠚", "⠒", "⠂", "⠂", "⠒", "⠲", "⠴", "⠤", "⠄", "⠄", "⠤", "⠠", "⠠", "⠤", "⠦", "⠖", "⠒", "⠐", "⠐", "⠒", "⠓", "⠋", "⠉", "⠈", "⠈", },
        dots9 = { "⢹", "⢺", "⢼", "⣸", "⣇", "⡧", "⡗", "⡏" },
        dots10 = { "⢄", "⢂", "⢁", "⡁", "⡈", "⡐", "⡠" },
        dots11 = { "⠁", "⠂", "⠄", "⡀", "⢀", "⠠", "⠐", "⠈" },
        dots12 = { "⢀⠀", "⡀⠀", "⠄⠀", "⢂⠀", "⡂⠀", "⠅⠀", "⢃⠀", "⡃⠀", "⠍⠀", "⢋⠀", "⡋⠀", "⠍⠁", "⢋⠁", "⡋⠁", "⠍⠉", "⠋⠉", "⠋⠉", "⠉⠙", "⠉⠙", "⠉⠩", "⠈⢙", "⠈⡙", "⢈⠩", "⡀⢙", "⠄⡙", "⢂⠩", "⡂⢘", "⠅⡘", "⢃⠨", "⡃⢐", "⠍⡐", "⢋⠠", "⡋⢀", "⠍⡁", "⢋⠁", "⡋⠁", "⠍⠉", "⠋⠉", "⠋⠉", "⠉⠙", "⠉⠙", "⠉⠩", "⠈⢙", "⠈⡙", "⠈⠩", "⠀⢙", "⠀⡙", "⠀⠩", "⠀⢘", "⠀⡘", "⠀⠨", "⠀⢐", "⠀⡐", "⠀⠠", "⠀⢀", "⠀⡀", },
        dots13 = { "⣼", "⣹", "⢻", "⠿", "⡟", "⣏", "⣧", "⣶" },
        dots14 = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        sand = { "⠁", "⠂", "⠄", "⡀", "⡈", "⡐", "⡠", "⣀", "⣁", "⣂", "⣄", "⣌", "⣔", "⣤", "⣥", "⣦", "⣮", "⣶", "⣷", "⣿", "⡿", "⠿", "⢟", "⠟", "⡛", "⠛", "⠫", "⢋", "⠋", "⠍", "⡉", "⠉", "⠑", "⠡", "⢁", },
    },
    kinds = {
        kind_1 = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Namespace = "ﱕ",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
        },
        kind_2 = {
            File = { " " },
            Module = { " " },
            Namespace = { "ﱕ " },
            Package = { " " },
            Class = { " " },
            Method = { " " },
            Property = { " " },
            Field = { "ﯟ " },
            Constructor = { " " },
            Enum = { " " },
            Interface = { " " },
            Function = { " " },
            Variable = { " " },
            Constant = { " " },
            String = { " " },
            Number = { " " },
            Boolean = { " " },
            Array = { " " },
            Object = { " " },
            Key = { " " },
            Null = { " " },
            EnumMember = { " " },
            Struct = { " " },
            Event = { " " },
            Operator = { " " },
            TypeParameter = { " " },
            TypeAlias = { " " },
            Parameter = { " " },
            StaticMethod = { " " },
            Macro = { "廓" },
        },

        kind_vsc = {
            File = " ",
            Module = " ",
            Namespace = " ",
            Package = " ",
            Class = " ",
            Method = " ",
            Property = " ",
            Field = " ",
            Constructor = " ",
            Enum = " ",
            Interface = " ",
            Function = " ",
            Variable = " ",
            Constant = " ",
            String = " ",
            Number = " ",
            Boolean = " ",
            Array = " ",
            Object = " ",
            Key = " ",
            Null = " ",
            EnumMember = " ",
            Struct = " ",
            Event = " ",
            Operator = " ",
            TypeParameter = " ",
        },
    },
}

local file_types = {
    lua = "",
}
_M = {
    ----------------------------------------------------------------------
    --                              debug                               --
    ----------------------------------------------------------------------
    debug_bug = "",
    debug_into = "",
    debug_out = "",
    debug_over = "",
    debug_breakpoint = "",
    debug_breakpoint_reject = "⚫", --
    debug_breakpoint_error = "🛑", -- 🔴
    debug_breakpoint_stop = "", -- 🟢

    ----------------------------------------------------------------------
    --                               git                                --
    ----------------------------------------------------------------------
    git_add = "+", -- 
    git_modified = "~",
    git_remove = "-",
    git_ignore = "◌",
    git_rename = "",
    git_diff = "",
    git_repo = "",
    git_branch = "",

    git_unstaged = "✗",
    git_staged = "✓",
    git_unmerged = "",
    git_renamed = "➜",
    git_untracked = "",
    git_ignored = "◌",
    git_deleted = "",
    git_change = "~",
    git_confict = "",

    ----------------------------------------------------------------------
    --                              lines                               --
    ----------------------------------------------------------------------
    line_horizontal = "-",
    line_horizontal_bottom = "_",
    line_horizontal_top = "‾",
    line_wave = "~",
    line_vertical = "│",
    line_bold = "▌",

    ----------------------------------------------------------------------
    --                              files                               --
    ----------------------------------------------------------------------
    folder = "",
    folder_open = "",
    folder_empty = "",
    folder_empty_open = "",
    file_link = "",
    file = "",
    collapsed = "",
    expanded = "",
    current = "",

    ----------------------------------------------------------------------
    --                               time                               --
    ----------------------------------------------------------------------
    clock = " ",

    ----------------------------------------------------------------------
    --                               diag                               --
    ----------------------------------------------------------------------
    hint = "●", -- 﫢
    info = "●", -- ●
    warning = "●", --﹗▲！⚠️
    error = "■", -- ■💊
    link = "", -- 
    null = "", -- 🚫
    todo = "",
    hack = "",
    note = "",
    perf = "龍",
    fix = "",
    bookmark = "🔖",
    trash = "", -- 🗑️
    deleted = "🕳️", -- 

    dot = "", -- 
    ok = " ",
    check = "",
    check_all = "",
    check_circle = "﫟",
    close = "",
    circle = "",

    unpack = "",
    pack = "",

    arrow_right = "",
    arrow_up = "",
    arrow_left = "",
    arrow_down = "",

    search = " ", --🔎 

    flash = "",
    bulb = "💡",
    flag = "",

    vim = "",
    skull = "💀",

    kind = warehouse.kinds.kind_1,
    spinner = warehouse.spinners.dots,
    file_types = file_types,

    ActiveLSP = "",
    ActiveTS = "",
    ArrowLeft = "",
    ArrowRight = "",
    BufferClose = "",
    DapBreakpoint = "",
    DapBreakpointCondition = "",
    DapBreakpointRejected = "",
    DapLogPoint = ".>",
    DapStopped = "",
    DefaultFile = "",
    Diagnostic = "裂",
    DiagnosticError = "",
    DiagnosticHint = "",
    DiagnosticInfo = "",
    DiagnosticWarn = "",
    Ellipsis = "…",
    FileModified = "",
    FileReadOnly = "",
    FoldClosed = "",
    FoldOpened = "",
    FoldSeparator = " ",
    FolderClosed = "",
    FolderEmpty = "",
    FolderOpen = "",
    Git = "",
    GitAdd = "",
    GitBranch = "",
    GitChange = "",
    GitConflict = "",
    GitDelete = "",
    GitIgnored = "◌",
    GitRenamed = "➜",
    GitStaged = "✓",
    GitUnstaged = "✗",
    GitUntracked = "★",
    LSPLoaded = "",
    LSPLoading1 = "",
    LSPLoading2 = "",
    LSPLoading3 = "",
    MacroRecording = "",
    Paste = "",
    Search = "",
    Selected = "❯",
    Spellcheck = "暈",
    TabClose = "",
}

return _M

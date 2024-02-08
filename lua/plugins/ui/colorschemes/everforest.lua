require("everforest").setup({
    transparent_background_level = 1,
    on_highlights = function(hl, palette)
        hl.WinBar = { fg = palette.bg, bg = "None" }
        hl.lineNr = { bg = "None" }
        hl.CursorLine = { fg = "None", bg = "None" }
        hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
        hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
        hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
        hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
    end,
})

require("everforest").load()

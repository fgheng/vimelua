local status_ok, colors = pcall(require, 'material')
if not status_ok then
    vim.notify('theme material not found')
    return
end

colors.setup({
    custom_highlights = {
        LineNr = { bg = '#FF0000' },
        CursorLine = { fg = '#0000FF', underline = true },

        -- This is a list of possible values
        YourHighlightGroup = {
            fg = "#SOME_COLOR", -- foreground color
            bg = "#SOME_COLOR", -- background color
            sp = "#SOME_COLOR", -- special color (for colored underlines, undercurls...)
            bold = false, -- make group bold
            italic = false, -- make group italic
            underline = false, -- make group underlined
            undercurl = false, -- make group undercurled
            underdot = false, -- make group underdotted
            underdash = false, -- make group underdotted
            striketrough = false, -- make group striked trough
            reverse = false, -- reverse the fg and bg colors
            link = "SomeOtherGroup" -- link to some other highlight group
        }
    }
})

pcall(vim.api.nvim_command, 'colorscheme material')

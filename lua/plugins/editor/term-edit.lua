require("term-edit").setup({
    -- Mandatory option:
    -- Set this to a lua pattern that would match the end of your prompt
    -- For most bash/zsh user this is '%$ '
    -- For most powershell/fish user this is '> '
    -- For most windows cmd user this is '>'
    prompt_end = "%$ ",
    -- How to write lua patterns: https://www.lua.org/pil/20.2.html
})

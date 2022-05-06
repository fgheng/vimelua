local g = vim.g
local cmd = vim.cmd

g.matchup_matchparen_deferred = 1
g.matchup_matchparen_hi_surround_always = 1
g.matchup_surround_enabled = 0
cmd [[let g:matchup_matchparen_offscreen = {'method': 'popup'}]]

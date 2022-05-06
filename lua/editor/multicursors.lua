local _M = {
    "smoka7/multicursors.nvim",
    enabled = true,
    dependencies = {
        "smoka7/hydra.nvim",
    },
    config = true,
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
        {
            mode = { "v", "n" },
            "<Leader>m",
            "<cmd>MCstart<cr>",
            desc = "Create a selection for selected text or word under the cursor",
        },
    },
}

return _M

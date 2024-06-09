return {
    "andymass/vim-matchup",
    enable = false,
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.g.matchup_mappings_enabled = 0
        vim.g.matchup_mouse_enabled = 0
        vim.g.matchup_text_obj_enabled = 0
        vim.g.matchup_motion_enabled = 0

        -- vim.g.matchup_matchparen_offscreen = { method = "popup" }
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_delim_noskips = 2 -- don't recognize anything in comments
    end,
}

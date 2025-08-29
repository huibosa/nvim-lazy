return {
    "nvim-mini/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    opts = {
        mappings = {
            add = "gsa",            -- Add surrounding in Normal and Visual modes
            delete = "gsd",         -- Delete surrounding
            find = "gsf",           -- Find surrounding (to the right)
            find_left = "gsF",      -- Find surrounding (to the left)
            highlight = "gsh",      -- Highlight surrounding
            replace = "gsr",        -- Replace surrounding
            update_n_lines = "gsn", -- Update `n_lines`
        },
    },
}

return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    cmd = { "FzfLua" },
    opts = {
        winopts = {
            border = vim.g.window_borders,
        },
        defaults = {
            file_icons = false,
        },
        lsp = {
            symbols = {
                symbol_style = false,
            },
        },
    },
    keys = {
        {
            "<c-\\>",
            function() require("fzf-lua").builtin() end,
            "Builtin",
        },
        {
            "<c-p>",
            function() require("fzf-lua").files() end,
            desc = "Files",
        },
        {
            "<c-q>",
            function() require("fzf-lua").live_grep_native() end,
            desc = "Live grep",
        },
    },
}

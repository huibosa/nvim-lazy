return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    cmd = { "FzfLua" },
    opts = {
        winopts = {
            border = vim.g.window_borders,
        },
        -- defaults = {
        --     file_icons = false,
        -- },
        -- lsp = {
        --     symbols = {
        --         symbol_style = false,
        --     },
        -- },
    },
    keys = {
        {
            "<c-_>",
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
        {
            "gd",
            function() require("fzf-lua").lsp_definitions() end,
            desc = "LSP definitions",
        },
        {
            "gD",
            function() require("fzf-lua").lsp_declarations() end,
            desc = "LSP declarations",
        },
        {
            "gr",
            function() require("fzf-lua").lsp_references() end,
            desc = "LSP references",
        },
        {
            "gT",
            function() require("fzf-lua").lsp_typedefs() end,
            desc = "LSP type definitions",
        },
        {
            "gI",
            function() require("fzf-lua").lsp_implementations() end,
            desc = "LSP implementations",
        },
        {
            "gs",
            function() require("fzf-lua").lsp_document_symbols() end,
            desc = "LSP document symbols",
        },
        {
            "gS",
            function() require("fzf-lua").lsp_live_workspace_symbols() end,
            desc = "LSP workspace symbols",
        },
    },
}

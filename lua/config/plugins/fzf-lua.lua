return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    cmd = { "FzfLua" },
    opts = {
        winopts = {
            border = vim.g.window_borders,
        },
        keymap = {
            builtin = {
                ["<C-d>"] = "preview-page-down",
                ["<C-u>"] = "preview-page-up",
            },
        },
        fzf_colors = {
            ["fg"] = { "fg", "Comment" },
            ["bg"] = "-1",
            ["hl"] = { "fg", "String" },
            ["fg+"] = { "fg", "Normal" },
            ["bg+"] = { "bg", "Visual" },
            ["hl+"] = { "fg", "String" },
            ["info"] = { "fg", "WarningMsg" },
            -- ["prompt"] = { "fg", "SpecialKey" },
            ["pointer"] = { "fg", "DiagnosticError" },
            ["marker"] = { "fg", "DiagnosticError" },
            ["spinner"] = { "fg", "Label" },
            ["header"] = { "fg", "Comment" },
            ["gutter"] = "-1",
            ["scrollbar"] = { "fg", "WarningMsg" },
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
            "gy",
            function() require("fzf-lua").lsp_typedefs() end,
            desc = "LSP type definitions",
        },
        {
            "gm",
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
    config = function(_, opts)
        require("fzf-lua").setup(opts)

        local dark = "#1b1b1b"
        local yellow = "#d8a657"

        vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = dark, bg = dark })
        vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = dark })
        vim.api.nvim_set_hl(0, "FzfLuaTitle", { bg = yellow })
    end,
}

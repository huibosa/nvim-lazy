local hls = {
    bg    = "PmenuSbar",
    sel   = "PmenuSel",
    title = "IncSearch"
}

return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    cmd = { "FzfLua" },
    opts = {
        defaults = {
            formatter = "path.filename_first",
        },
        winopts = {
            preview = {
                hidden = true,
            }
        },
        hls = {
            title         = hls.title,
            preview_title = hls.title,
            scrollfloat_e = "",
            scrollfloat_f = hls.sel,
        },
        fzf_colors = {
            ["fg"] = { "fg", "Comment" },
            ["bg"] = "-1",
            ["hl"] = { "fg", "String" },
            ["fg+"] = { "fg", "Normal" },
            -- ["bg+"] = { "bg", "Visual" },
            ["hl+"] = { "fg", "String" },
            ["info"] = { "fg", "WarningMsg" },
            -- ["prompt"] = { "fg", "SpecialKey" },
            -- ["pointer"] = { "fg", "DiagnosticError" },
            -- ["marker"] = { "fg", "DiagnosticError" },
            ["spinner"] = { "fg", "Label" },
            ["header"] = { "fg", "Comment" },
            ["gutter"] = "-1",
            ["scrollbar"] = { "fg", "WarningMsg" },
        },
    },
    keys = {
        {
            "<C-\\>",
            function() require("fzf-lua").builtin() end,
            "Builtin",
        },
        {
            "<C-p>",
            function() require("fzf-lua").global() end,
            desc = "Files",
        },
        {
            "<LEADER>ff",
            function() require("fzf-lua").files() end,
            desc = "Files",
        },
        {
            "<LEADER>fR",
            function() require("fzf-lua").oldfiles({ cwd = vim.uv.cwd() }) end,
            desc = "Recent (cwd)",
        },
        {
            "<LEADER>fr",
            function() require("fzf-lua").oldfiles() end,
            desc = "Recent (all)",
        },
        {
            "<LEADER>fb",
            function() require("fzf-lua").buffers() end,
            desc = "Buffers",
        },
        {
            "<LEADER>fc",
            function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
            desc = "Config",
        },
        -- Search
        {
            "<C-q>",
            function() require("fzf-lua").live_grep_native({ resume = true }) end,
            desc = "Live Grep",
        },
        {
            "<LEADER>sc",
            function() require("fzf-lua").command_history() end,
            desc = "Cursor Word",
        },
        {
            "<LEADER>sw",
            function() require("fzf-lua").grep_cword() end,
            desc = "Cursor Word",
        },
        {
            "<LEADER>sW",
            function() require("fzf-lua").grep_cWORD() end,
            desc = "Cursor WORD",
        },
        {
            "<LEADER>sd",
            function() require("fzf-lua").lsp_definitions() end,
            desc = "Definitions",
        },
        {
            "<LEADER>sD",
            function() require("fzf-lua").lsp_declarations() end,
            desc = "Declarations",
        },
        {
            "<LEADER>sr",
            function() require("fzf-lua").lsp_references() end,
            desc = "References",
        },
        {
            "<LEADER>sy",
            function() require("fzf-lua").lsp_typedefs() end,
            desc = "Type Definitions",
        },
        {
            "<LEADER>sI",
            function() require("fzf-lua").lsp_implementations() end,
            desc = "Implementations",
        },
        {
            "<LEADER>ss",
            function() require("fzf-lua").lsp_document_symbols() end,
            desc = "Symbols (document)",
        },
        {
            "<LEADER>sS",
            function() require("fzf-lua").lsp_live_workspace_symbols() end,
            desc = "Symbols (workspace)",
        },
        {
            "<LEADER>sa",
            function() require("fzf-lua").lsp_code_actions() end,
            desc = "Code Actions",
        },
        {
            "<LEADER>sG",
            function() require("fzf-lua").diagnostics_document() end,
            desc = "Diagnostics (document)",
        },
        {
            "<LEADER>sg",
            function() require("fzf-lua").diagnostics_workspace() end,
            desc = "Diagnostics (Workspace)",
        },
        {
            "<LEADER>sl",
            function() require("fzf-lua").blines() end,
            desc = "Lines (document)",
        },
        {
            "<LEADER>sL",
            function() require("fzf-lua").lines() end,
            desc = "Lines (workspace)",
        },
        {
            "<LEADER>sh",
            function() require("fzf-lua").helptags() end,
            desc = "Help",
        },
    },
    config = function(_, opts)
        require("fzf-lua").setup(opts)

        local dark = "#45403d"
        local yellow = "#d8a657"

        vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = dark, bg = dark })
        vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = dark })
        vim.api.nvim_set_hl(0, "FzfLuaTitle", { bg = yellow })
    end,
}

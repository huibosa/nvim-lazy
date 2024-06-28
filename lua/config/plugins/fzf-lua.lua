return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    cmd = { "FzfLua" },
    opts = {
        keymap = {
            builtin = {
                ["<C-d>"] = "preview-down",
                ["<C-u>"] = "preview-up",
                ["<C-_>"] = "toggle-help",
            },
            fzf = {
                ["ctrl-f"] = "forward-char",
                ["ctrl-b"] = "backward-char",
                ["ctrl-k"] = "kill-line",
            },
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
            "<LEADER><LEADER>",
            function() require("fzf-lua").builtin() end,
            "Builtin",
        },
        {
            "<C-p>",
            function() require("fzf-lua").files() end,
            desc = "Files",
        },
        {
            "<LEADER>fF",
            function() require("fzf-lua").files({ cwd = vim.uv.cwd() }) end,
            desc = "Files (cwd)",
        },
        {
            "<LEADER>ff",
            function() require("fzf-lua").files() end,
            desc = "Files",
        },
        {
            "<LEADER>fR",
            function() require("fzf-lua").oldfiles({ cwd = vim.uv.cwd() }) end,
            desc = "Recent Files (cwd)",
        },
        {
            "<LEADER>fr",
            function() require("fzf-lua").oldfiles() end,
            desc = "Recent Files",
        },
        {
            "<LEADER>fb",
            function() require("fzf-lua").buffers() end,
            desc = "Buffers",
        },
        -- Search
        {
            "<C-q>",
            function() require("fzf-lua").live_grep_native() end,
            desc = "Live Grep",
        },
        {
            "<LEADER>sw",
            function() require("fzf-lua").grep_cword() end,
            desc = "Grep Cursor Word",
        },
        {
            "<LEADER>sW",
            function() require("fzf-lua").grep_cWORD() end,
            desc = "Grep Cursor WORD",
        },
        {
            "<LEADER>sd",
            function() require("fzf-lua").lsp_definitions() end,
            desc = "LSP Definitions",
        },
        {
            "<LEADER>sD",
            function() require("fzf-lua").lsp_declarations() end,
            desc = "LSP Declarations",
        },
        {
            "<LEADER>sr",
            function() require("fzf-lua").lsp_references() end,
            desc = "LSP References",
        },
        {
            "<LEADER>sy",
            function() require("fzf-lua").lsp_typedefs() end,
            desc = "LSP Type Definitions",
        },
        {
            "<LEADER>sI",
            function() require("fzf-lua").lsp_implementations() end,
            desc = "LSP Implementations",
        },
        {
            "<LEADER>ss",
            function() require("fzf-lua").lsp_document_symbols() end,
            desc = "LSP Document Symbols",
        },
        {
            "<LEADER>sS",
            function() require("fzf-lua").lsp_live_workspace_symbols() end,
            desc = "LSP Workspace Symbols",
        },
        {
            "<LEADER>sa",
            function() require("fzf-lua").lsp_code_actions() end,
            desc = "LSP Code Actions",
        },
        {
            "<LEADER>sG",
            function() require("fzf-lua").diagnostics_document() end,
            desc = "Document Diagnostics",
        },
        {
            "<LEADER>sg",
            function() require("fzf-lua").diagnostics_workspace() end,
            desc = "Workspace Diagnostics",
        },
        {
            "<LEADER>sl",
            function() require("fzf-lua").blines() end,
            desc = "Current Buffer Lines",
        },
        {
            "<LEADER>sL",
            function() require("fzf-lua").lines() end,
            desc = "All Lines",
        },
        {
            "<LEADER>sh",
            function() require("fzf-lua").helptags() end,
            desc = "Help",
        },
        -- Git
        {
            "<LEADER>gc",
            function() require("fzf-lua").git_commits() end,
            desc = "Commits",
        },
        {
            "<LEADER>gs",
            function() require("fzf-lua").git_status() end,
            desc = "Status",
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

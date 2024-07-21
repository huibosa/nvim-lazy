return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")

        wk.setup({
            replace = {
                key = {
                    { "<Space>", "SPC" },
                    { "<CR>", "RET" },
                    { "<TAB>", "TAB" },
                },
            },
        })

        wk.add({
            { "g", group = "+Goto" },
            { "gs", group = "+Surround", icon = " " },
            { "gx", desc = "Open file/URI" },
            { "gf", desc = "Go file" },
            { "gt", desc = "Next tab" },
            { "gT", desc = "Prev tab" },
            { "gi", desc = "Last insert" },
            { "g%", desc = "Cycle backwards" },

            { "]", group = "+Next", icon = "" },
            { "[", group = "+Prev", icon = "" },

            { "<LEADER><SPACE>", group = "FzfLua" },
            { "<LEADER>f", group = "+File/Find" },
            { "<LEADER>s", group = "+Search" },
            { "<LEADER>g", group = "+Git" },
            { "<LEADER>gh", group = "+Hunk" },
            { "<LEADER>c", group = "+Code" },
            { "<LEADER>cw", group = "+Workspace" },
            { "<LEADER>cs", group = "+Swap" },
        })
    end,
}

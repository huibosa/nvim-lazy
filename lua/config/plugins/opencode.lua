return {
    "sudo-tee/opencode.nvim",
    cmd = { "Opencode" },
    keys = {
        { "<leader>og", desc = "Toggle Opencode" },
        { "<leader>o", group = "+Opencode" },
    },
    config = function()
        require("opencode").setup({
            preferred_picker = "fzf",
            preferred_completion = "blink",
            keymap = {
                editor = {
                    ["<leader>og"] = { "toggle" },
                    ["<leader>oi"] = { "open_input" },
                    ["<leader>oo"] = { "open_output" },
                    ["<leader>ot"] = { "toggle_focus" },
                    ["<leader>oq"] = { "close" },
                    ["<leader>os"] = { "select_session" },
                    ["<leader>od"] = { "diff_open" },
                    ["<leader>ox"] = { "swap_position" },
                    ["<leader>o/"] = { "quick_chat", mode = { "n", "x" } },
                },
            },
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                anti_conceal = { enabled = false },
                file_types = { "markdown", "opencode_output" },
            },
            ft = { "markdown", "opencode_output" },
        },
        "saghen/blink.cmp",
        "ibhagwan/fzf-lua",
    },
}

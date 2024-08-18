return {
    "kevinhwang91/nvim-bqf",
    event = "FileType qf",
    config = function()
        vim.api.nvim_set_hl(0, "BqfPreviewFloat", { link = "FloatBorder" })

        require("bqf").setup({
            preview = {
                border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
                show_title = false,
                winblend = 0,
            },
        })
    end,
}

return {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
        vim.api.nvim_set_hl(0, "BqfPreviewFloat", { link = "FloatBorder" })

        require("bqf").setup({
            preview = {
                border = 'solid',
                show_title = false,
                winblend = 0,
                auto_preview = false,
            },
            func_map = {
                ptogglemode = '<F2>',
                ptoggleauto = '<F4>',
            }
        })
    end,
}

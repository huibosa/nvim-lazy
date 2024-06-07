return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function() vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#928374", bg = "#45403d" }) end,
}

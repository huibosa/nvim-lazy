return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
        require('nvim-treesitter').install({ 'rust', 'go', 'c', 'cpp', 'python' })

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        -- Enable highlight
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'python', 'go' },
            callback = function() vim.treesitter.start() end,
        })
    end
}

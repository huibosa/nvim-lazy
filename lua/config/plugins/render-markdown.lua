return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-mini/mini.icons',
    },
    ft = { 'markdown' },
    opts = {
        anti_conceal = { enabled = false },
        heading = {
            sign = false,
            icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
        },
        code = {
            sign = false,
            conceal_delimiters = false,
            border = 'none',
        },
    },
}

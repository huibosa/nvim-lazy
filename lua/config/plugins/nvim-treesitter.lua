return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
        local ts = require('nvim-treesitter')

        ts.install({
            'rust', 'go', 'c', 'cpp', 'python', 'lua',
            'bash',
            'comment',
            'css',
            'diff',
            'fish',
            'git_config',
            'git_rebase',
            'gitcommit',
            'gitignore',
            'html',
            'javascript',
            'json',
            'latex',
            'luadoc',
            'make',
            'markdown',
            'markdown_inline',
            'norg',
            'query',
            'regex',
            'scss',
            'svelte',
            'toml',
            'tsx',
            'typescript',
            'typst',
            'vim',
            'vimdoc',
            'vue',
            'xml',
        })

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Enable highlight
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'python', 'go' },
            callback = function() vim.treesitter.start() end,
        })
    end
}

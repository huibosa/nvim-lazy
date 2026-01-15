return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
        local ts = require('nvim-treesitter')

        local ensure_installed = {
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
        }
        ts.install(ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = ensure_installed,
            callback = function()
                -- syntax highlighting, provided by Neovim
                vim.treesitter.start()
                -- folds, provided by Neovim
                vim.opt.foldmethod = "expr"
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                -- indentation, provided by nvim-treesitter
                -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}

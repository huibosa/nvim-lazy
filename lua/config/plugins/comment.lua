return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('Comment').setup({})

        vim.api.nvim_set_keymap('n', '<c-_>', 'gcc', { desc = 'Toggle comment' })
        vim.api.nvim_set_keymap('v', '<c-_>', 'gc', { desc = 'Toggle comment' })
    end,
}

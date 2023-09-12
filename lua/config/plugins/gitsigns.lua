return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            signs = {
                add = { hl = "GitSignsAdd", text = "▐", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = {
                    hl = "GitSignsChange",
                    text = "▐",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                delete = {
                    hl = "GitSignsDelete",
                    text = "▁",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
                topdelete = {
                    hl = "GitSignsDelete",
                    text = "▔",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
                changedelete = {
                    hl = "GitSignsChange",
                    text = "▟",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                untracked = {
                    hl = "GitSignsUntracked",
                    text = "▐ ",
                    numhl = "GitSignsUntrackedNr",
                    linehl = "GitSignsUntrackedLn",
                },
            },
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end

                -- Navigation
                map('n', ']h', "&diff ? ']h' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
                map('n', '[h', "&diff ? '[h' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

                -- Actions
                map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = '[Stage] hunk' })
                map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = '[Stage] hunk' })
                map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = '[Reset] hunk' })
                map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = '[Stage] hunk' })
                map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', { desc = 'Stage [buffer]' })
                map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', { desc = '[Unstage] hunk' })
                map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', { desc = '[Reset] buffer' })
                map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', { desc = '[Preview] hunk' })
                map('n', '<leader>hbf', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
                    { desc = '[Blame] float' })
                map('n', '<leader>hbt', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = 'Blame line [toggle]' })
                map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>', { desc = '[Diff] hunk' })
                map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>', { desc = '[Diff] hunk' })
                map('n', '<leader>ht', '<cmd>Gitsigns toggle_deleted<CR>', { desc = '[Toggle] hunk' })

                -- Text object
                map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = '[Hunk]' })
                map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = '[Hunk]' })
            end
        })
    end,
}

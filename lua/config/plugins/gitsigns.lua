return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            attach_to_untracked = true,
            worktrees = {
                {
                    toplevel = vim.env.HOME,
                    gitdir = vim.env.HOME .. "/.dotfiles",
                },
            },
            -- ┃🮇 🮈 ▐
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "┃" },
                untracked = { text = "┇" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend("force", {
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                    }, opts or {})
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Actions for stage
                map({ "n", "v" }, "<LEADER>hs", ":<C-u>Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
                map({ "n", "v" }, "<LEADER>hr", ":<C-u>Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
                map("n", "<LEADER>hS", gs.stage_buffer, { desc = "Stage Buffer" })
                map("n", "<LEADER>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
                map("n", "<LEADER>hR", gs.reset_buffer, { desc = "Reset Buffer" })

                map("n", "<LEADER>hp", gs.preview_hunk_inline, { desc = "Preview hunk Inline" })
                map("n", "<LEADER>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
                map("n", "<LEADER>hd", gs.diffthis, { desc = "Diff This" })
                map("n", "<LEADER>hD", function() gs.diffthis("~") end, { desc = "Diff This ~" })

                -- map("n", "<LEADER>ght", gs.toggle_current_line_blame, { desc = "Blame line toggle" })
                -- map("n", "<LEADER>ght", gs.toggle_deleted, { desc = "Toggle hunk" })

                map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", { desc = "Hunk" })
            end,
        })
    end,
}

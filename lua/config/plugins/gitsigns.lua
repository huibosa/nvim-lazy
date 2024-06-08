return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Actions for stage
            map("n", "<LEADER>hs", gs.stage_hunk, { desc = "Stage Hunk" })
            map("n", "<LEADER>hr", gs.reset_hunk, { desc = "Reset Hunk" })
            map(
                "v",
                "<LEADER>hs",
                function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Stage Hunk" }
            )
            map(
                "v",
                "<LEADER>hr",
                function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Reset Hunk" }
            )
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
    },
}

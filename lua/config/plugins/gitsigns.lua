return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            worktrees = {
                {
                    toplevel = vim.env.HOME,
                    gitdir = vim.env.HOME .. "/.dotfiles",
                },
            },
            -- 🮇 🮈 ▐
            signs = {
                add = { text = "🮈" },
                change = { text = "🮈" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "🮈" },
                untracked = { text = "🮈" },
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
                map("n", "<leader>ga", gs.stage_hunk, { desc = "Stage hunk" })
                map("n", "<leader>gA", gs.stage_buffer, { desc = "Stage buffer" })
                map(
                    "v",
                    "<leader>ga",
                    function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "Stage hunk" }
                )

                -- Actions for reset
                map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
                map(
                    "v",
                    "<leader>gr",
                    function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "Stage hunk" }
                )
                map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })

                -- Action for undo stage
                map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Unstage hunk" })

                map("n", "<leader>gbf", function() gs.blame_line({ full = true }) end, { desc = "Blame float" })
                map("n", "<leader>gbt", gs.toggle_current_line_blame, { desc = "Blame line toggle" })

                map("n", "<leader>gdd", gs.diffthis, { desc = "Diff hunk" })
                map("n", "<leader>gdD", function() gs.diffthis("~") end, { desc = "Diff hunk" })
                map("n", "<leader>gdt", gs.toggle_deleted, { desc = "Toggle hunk" })
                map("n", "<leader>gdp", gs.preview_hunk, { desc = "Preview hunk" })

                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Hunk" })
            end,
        })
    end,
}

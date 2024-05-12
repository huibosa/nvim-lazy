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
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend("force", {
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                    }, opts or {})
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Navigation
                -- map("n", "]h", function()
                --     if vim.wo.diff then return "]h" end
                --     vim.schedule(function() gs.next_hunk() end)
                --     return "<Ignore>"
                -- end, { expr = true })
                --
                -- map("n", "[h", function()
                --     if vim.wo.diff then return "[h" end
                --     vim.schedule(function() gs.prev_hunk() end)
                --     return "<Ignore>"
                -- end, { expr = true })

                -- Actions
                map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
                map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
                map(
                    "v",
                    "<leader>gs",
                    function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "Stage hunk" }
                )
                map(
                    "v",
                    "<leader>gr",
                    function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "Stage hunk" }
                )
                map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Unstage hunk" })
                map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
                map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>gbf", function() gs.blame_line({ full = true }) end, { desc = "Blame float" })
                map("n", "<leader>gbt", gs.toggle_current_line_blame, { desc = "Blame line toggle" })
                map("n", "<leader>gd", gs.diffthis, { desc = "Diff hunk" })
                map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff hunk" })
                map("n", "<leader>gt", gs.toggle_deleted, { desc = "Toggle hunk" })

                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Hunk" })
            end,
        })
    end,
}

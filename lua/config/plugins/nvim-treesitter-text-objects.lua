return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        ["a="] = { query = "@assignment.outer", desc = "outer assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "inner assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "outer parameter" },
                        ["ia"] = { query = "@parameter.inner", desc = "inner parameter" },

                        ["aj"] = { query = "@conditional.outer", desc = "outer conditional" },
                        ["ij"] = { query = "@conditional.inner", desc = "inner conditional" },

                        ["al"] = { query = "@loop.outer", desc = "outer loop" },
                        ["il"] = { query = "@loop.inner", desc = "inner loop" },

                        -- ["ab"] = { query = "@block.outer", desc = "outer block" },
                        -- ["ib"] = { query = "@block.inner", desc = "inner block" },

                        ["af"] = { query = "@function.outer", desc = "outer function" },
                        ["if"] = { query = "@function.inner", desc = "inner function" },

                        ["ac"] = { query = "@class.outer", desc = "outer class" },
                        ["ic"] = { query = "@class.inner", desc = "inner class" },

                        ["ar"] = { query = "@return.outer", desc = "outer return" },
                        ["ir"] = { query = "@return.outer", desc = "inner return" },

                        ["a/"] = { query = "@comment.outer", desc = "outer comment" },
                        ["i/"] = { query = "@comment.inner", desc = "inner comment" },
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner", -- swap object under cursor with next
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner", -- swap object under cursor with previous
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]a"] = { query = "@parameter.outer", desc = "Next argument start" },
                        ["]f"] = { query = "@function.outer", desc = "Next function start" },
                        ["]r"] = { query = "@return.outer", desc = "Next return start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]j"] = { query = "@conditional.outer", desc = "Next judge start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                    },
                    goto_next_end = {
                        ["]A"] = { query = "@parameter.outer", desc = "Next argument end" },
                        ["]F"] = { query = "@function.outer", desc = "Next function end" },
                        ["]R"] = { query = "@return.outer", desc = "Next return end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                        ["]J"] = { query = "@conditional.outer", desc = "Next judge end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                    },
                    goto_previous_start = {
                        ["[a"] = { query = "@parameter.outer", desc = "Previous argument start" },
                        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                        ["[r"] = { query = "@return.outer", desc = "Previous return start" },
                        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                        ["[j"] = { query = "@conditional.outer", desc = "Previous judge start" },
                        ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
                    },
                    goto_previous_end = {
                        ["[A"] = { query = "@parameter.outer", desc = "Previous argument end" },
                        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                        ["[R"] = { query = "@return.outer", desc = "Previous return end" },
                        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                        ["[J"] = { query = "@conditional.outer", desc = "Previous judge end" },
                        ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
                    },
                },
            },
        })
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- Repeat movement with ; and ,
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

        -- example: make gitsigns.nvim movement repeatable with ; and , keys.
        local gs = require("gitsigns")

        -- make sure forward function comes first
        local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
        -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

        vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat, { desc = "Next hunk" })
        vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat, { desc = "Prev hunk" })
    end,
}

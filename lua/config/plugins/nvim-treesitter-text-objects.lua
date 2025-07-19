return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                include_surrounding_whitespace = true,
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

                    -- ["am"] = { query = "@comment.outer", desc = "outer comment" },
                    -- ["im"] = { query = "@comment.inner", desc = "inner comment" },
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<LEADER>csn"] = "@parameter.inner", -- swap object under cursor with next
                },
                swap_previous = {
                    ["<LEADER>csp"] = "@parameter.inner", -- swap object under cursor with previous
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]a"] = { query = "@parameter.outer", desc = "Next argument start" },
                    ["]f"] = { query = "@function.outer", desc = "Next function start" },
                    ["]e"] = { query = "@return.outer", desc = "Next return start" },
                    ["]c"] = { query = "@class.outer", desc = "Next class start" },
                    ["]j"] = { query = "@conditional.outer", desc = "Next judge start" },
                    ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                },
                goto_next_end = {
                    ["]A"] = { query = "@parameter.outer", desc = "Next argument end" },
                    ["]F"] = { query = "@function.outer", desc = "Next function end" },
                    ["]E"] = { query = "@return.outer", desc = "Next return end" },
                    ["]C"] = { query = "@class.outer", desc = "Next class end" },
                    ["]J"] = { query = "@conditional.outer", desc = "Next judge end" },
                    ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                },
                goto_previous_start = {
                    ["[a"] = { query = "@parameter.outer", desc = "Previous argument start" },
                    ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                    ["[e"] = { query = "@return.outer", desc = "Previous return start" },
                    ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                    ["[j"] = { query = "@conditional.outer", desc = "Previous judge start" },
                    ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
                },
                goto_previous_end = {
                    ["[A"] = { query = "@parameter.outer", desc = "Previous argument end" },
                    ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                    ["[E"] = { query = "@return.outer", desc = "Previous return end" },
                    ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                    ["[J"] = { query = "@conditional.outer", desc = "Previous judge end" },
                    ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
                },
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- Repeat movement with ; and , vim way
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

        -- Make ]h, [h also repeatable with ; and ,
        local gs = require("gitsigns")
        local next_hunk = function() gs.nav_hunk("next", { target = "all" }) end
        local prev_hunk = function() gs.nav_hunk("prev", { target = "all" }) end
        local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(next_hunk, prev_hunk)

        vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat, { desc = "Next Hunk" })
        vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat, { desc = "Prev Hunk" })

        -- Make ]d, [d also repeatable with ; and ,
        local next_diagnostic = function() vim.diagnostic.jump({ count = 1, float = true }) end
        local prev_diagnostic = function() vim.diagnostic.jump({ count = -1, float = true }) end
        local next_diagnostic_repeat, prev_diagnostic_repeat =
            ts_repeat_move.make_repeatable_move_pair(next_diagnostic, prev_diagnostic)
        vim.keymap.set({ "n", "x", "o" }, "]d", next_diagnostic_repeat, { desc = "Next Diagnostic" })
        vim.keymap.set({ "n", "x", "o" }, "[d", prev_diagnostic_repeat, { desc = "Prev Diagnostic" })

        -- Make ]b, [b also repeatable with ; and ,
        local next_buffer = function()
            vim.api.nvim_command("bnext")
            vim.api.nvim_command("file")
        end
        local prev_buffer = function()
            vim.api.nvim_command("bprev")
            vim.api.nvim_command("file")
        end
        local next_buffer_repeat, prev_buffer_repeat =
            ts_repeat_move.make_repeatable_move_pair(next_buffer, prev_buffer)
        vim.keymap.set({ "n", "x", "o" }, "]b", next_buffer_repeat, { desc = "Next Buffer" })
        vim.keymap.set({ "n", "x", "o" }, "[b", prev_buffer_repeat, { desc = "Prev Buffer" })

        -- Create ]] and [r for go to refereces under cursor
        local illuminate = require("illuminate")
        local next_rf_repeat, prev_rf_repeat =
            ts_repeat_move.make_repeatable_move_pair(illuminate.goto_next_reference, illuminate.goto_prev_reference)

        vim.keymap.set({ "n", "x", "o" }, "]r", next_rf_repeat, { desc = "Next Reference" })
        vim.keymap.set({ "n", "x", "o" }, "[r", prev_rf_repeat, { desc = "Prev Reference" })

        -- -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        -- vim.api.nvim_create_autocmd("FileType", {
        --     callback = function()
        --         local buffer = vim.api.nvim_get_current_buf()
        --         vim.keymap.set({ "n", "x", "o" }, "]]", next_rf_repeat, { desc = "Next Reference", buffer = buffer })
        --         vim.keymap.set({ "n", "x", "o" }, "[[", prev_rf_repeat, { desc = "Prev Reference", buffer = buffer })
        --     end,
        -- })

        -- Create ]q, [q for quickfix list and make them repeatable with ; and ,
        local check_quickfix_then_run = function(cmd)
            local qf = vim.fn.getqflist()
            if vim.tbl_isempty(qf) then return end

            local qf_idx = vim.fn.getqflist({ idx = 0 }).idx

            if qf_idx == 1 and cmd == "cprev" then
                vim.api.nvim_command("clast")
            elseif qf_idx == #qf and cmd == "cnext" then
                vim.api.nvim_command("cfirst")
            else
                vim.api.nvim_command(cmd)
            end
        end

        local next_qf = function() check_quickfix_then_run("cnext") end
        local prev_qf = function() check_quickfix_then_run("cprev") end
        local next_qf_repeat, prev_qf_repeat = ts_repeat_move.make_repeatable_move_pair(next_qf, prev_qf)
        vim.keymap.set({ "n", "x", "o" }, "]q", next_qf_repeat, { desc = "Next QuickFix" })
        vim.keymap.set({ "n", "x", "o" }, "[q", prev_qf_repeat, { desc = "Prev QuickFix" })

        -- Create ]Q and [Q
        local first_qf = function() check_quickfix_then_run("cfirst") end
        local last_qf = function() check_quickfix_then_run("clast") end
        vim.keymap.set({ "n", "x", "o" }, "[Q", first_qf, { desc = "First QuickFix" })
        vim.keymap.set({ "n", "x", "o" }, "]Q", last_qf, { desc = "Last QuickFix" })
    end,
}

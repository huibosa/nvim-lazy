return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    branch = "main",
    opts = {
        select = {
            lookahead = true,
            include_surrounding_whitespace = true,
            selection_modes = {
                ["@parameter.outer"] = "v",
                ["@function.outer"] = "V",
                ["@class.outer"] = "<c-v>",
            },
        },
        move = {
            set_jumps = true,
        },
    },
    config = function(_, opts)
        require("nvim-treesitter-textobjects").setup(opts)

        -- Select
        local select = require("nvim-treesitter-textobjects.select").select_textobject
        local keymap = vim.keymap.set
        local modes = { "x", "o" }

        keymap(modes, "a=", function() select("@assignment.outer", "textobjects") end, { desc = "outer assignment" })
        keymap(modes, "i=", function() select("@assignment.inner", "textobjects") end, { desc = "inner assignment" })

        keymap(modes, "aa", function() select("@parameter.outer", "textobjects") end, { desc = "outer parameter" })
        keymap(modes, "ia", function() select("@parameter.inner", "textobjects") end, { desc = "inner parameter" })

        keymap(modes, "aj", function() select("@conditional.outer", "textobjects") end, { desc = "outer conditional" })
        keymap(modes, "ij", function() select("@conditional.inner", "textobjects") end, { desc = "inner conditional" })

        keymap(modes, "ao", function() select("@loop.outer", "textobjects") end, { desc = "outer loop" })
        keymap(modes, "io", function() select("@loop.inner", "textobjects") end, { desc = "inner loop" })

        keymap(modes, "ab", function() select("@block.outer", "textobjects") end, { desc = "outer block" })
        keymap(modes, "ib", function() select("@block.inner", "textobjects") end, { desc = "inner block" })

        keymap(modes, "af", function() select("@function.outer", "textobjects") end, { desc = "outer function" })
        keymap(modes, "if", function() select("@function.inner", "textobjects") end, { desc = "inner function" })

        keymap(modes, "ac", function() select("@class.outer", "textobjects") end, { desc = "outer class" })
        keymap(modes, "ic", function() select("@class.inner", "textobjects") end, { desc = "inner class" })

        keymap(modes, "ar", function() select("@return.outer", "textobjects") end, { desc = "outer return" })
        keymap(modes, "ir", function() select("@return.inner", "textobjects") end, { desc = "inner return" })

        keymap(modes, "a/", function() select("@comment.outer", "textobjects") end, { desc = "outer comment" })
        keymap(modes, "i/", function() select("@comment.inner", "textobjects") end, { desc = "inner comment" })

        -- Swap
        local swap = require("nvim-treesitter-textobjects.swap")

        vim.keymap.set("n", "<leader>csn", function() swap.swap_next("@parameter.inner") end,
            { desc = "Swap with next param" })
        vim.keymap.set("n", "<leader>csp", function() swap.swap_previous("@parameter.inner") end,
            { desc = "Swap with prev param" })

        -- Move
        local move = require("nvim-treesitter-textobjects.move")
        local move_modes = { "n", "x", "o" }

        -- Goto next start
        keymap(move_modes, "]a", function() move.goto_next_start("@parameter.outer", "textobjects") end,
            { desc = "Next arg start" })
        keymap(move_modes, "]f", function() move.goto_next_start("@function.outer", "textobjects") end,
            { desc = "Next func start" })
        keymap(move_modes, "]r", function() move.goto_next_start("@return.outer", "textobjects") end,
            { desc = "Next return start" })
        keymap(move_modes, "]c", function() move.goto_next_start("@class.outer", "textobjects") end,
            { desc = "Next class start" })
        keymap(move_modes, "]j", function() move.goto_next_start("@conditional.outer", "textobjects") end,
            { desc = "Next cond start" })
        keymap(move_modes, "]o", function() move.goto_next_start("@loop.outer", "textobjects") end,
            { desc = "Next loop start" })
        keymap(move_modes, "]/", function() move.goto_next_start("@comment.outer", "textobjects") end,
            { desc = "Next loop start" })

        -- Goto next end
        keymap(move_modes, "]A", function() move.goto_next_end("@parameter.outer", "textobjects") end)
        keymap(move_modes, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
        keymap(move_modes, "]R", function() move.goto_next_end("@return.outer", "textobjects") end)
        keymap(move_modes, "]C", function() move.goto_next_end("@class.outer", "textobjects") end)
        keymap(move_modes, "]J", function() move.goto_next_end("@conditional.outer", "textobjects") end)
        keymap(move_modes, "]O", function() move.goto_next_end("@loop.outer", "textobjects") end)

        -- Goto previous start
        keymap(move_modes, "[a", function() move.goto_previous_start("@parameter.outer", "textobjects") end)
        keymap(move_modes, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
        keymap(move_modes, "[r", function() move.goto_previous_start("@return.outer", "textobjects") end)
        keymap(move_modes, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end)
        keymap(move_modes, "[j", function() move.goto_previous_start("@conditional.outer", "textobjects") end)
        keymap(move_modes, "[o", function() move.goto_previous_start("@loop.outer", "textobjects") end)
        keymap(move_modes, "[/", function() move.goto_previous_start("@comment.outer", "textobjects") end)

        -- Goto previous end
        keymap(move_modes, "[A", function() move.goto_previous_end("@parameter.outer", "textobjects") end)
        keymap(move_modes, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)
        keymap(move_modes, "[R", function() move.goto_previous_end("@return.outer", "textobjects") end)
        keymap(move_modes, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end)
        keymap(move_modes, "[J", function() move.goto_previous_end("@conditional.outer", "textobjects") end)
        keymap(move_modes, "[O", function() move.goto_previous_end("@loop.outer", "textobjects") end)

        local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

        local make_repeatable_move_pair = function(forward_move_fn, backward_move_fn)
            local general_repeatable_move_fn = function(opts_, ...)
                if opts_.forward then
                    forward_move_fn(...)
                else
                    backward_move_fn(...)
                end
            end

            local repeatable_forward_move_fn = function(...)
                ts_repeat_move.last_move = { func = general_repeatable_move_fn, opts = { forward = true }, additional_args = { ... } }
                forward_move_fn(...)
            end

            local repeatable_backward_move_fn = function(...)
                ts_repeat_move.last_move = { func = general_repeatable_move_fn, opts = { forward = false }, additional_args = { ... } }
                backward_move_fn(...)
            end

            return repeatable_forward_move_fn, repeatable_backward_move_fn
        end

        -- Repeat movement with ; and , vim way
        keymap(move_modes, ";", ts_repeat_move.repeat_last_move)
        keymap(move_modes, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Make builtin f, F, t, T also repeatable with ; and ,
        keymap(move_modes, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        keymap(move_modes, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        keymap(move_modes, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        keymap(move_modes, "T", ts_repeat_move.builtin_T_expr, { expr = true })

        -- Make ]d, [d also repeatable with ; and ,
        local next_diag = function() vim.diagnostic.jump({ count = 1, float = true }) end
        local prev_diag = function() vim.diagnostic.jump({ count = -1, float = true }) end
        local next_diag_repeat, prev_diag_repeat = make_repeatable_move_pair(next_diag, prev_diag)
        keymap(move_modes, "]d", next_diag_repeat, { desc = "Next Diagnostic" })
        keymap(move_modes, "[d", prev_diag_repeat, { desc = "Prev Diagnostic" })

        -- Another approach
        -- local move_diag = function(opts_)
        --     vim.diagnostic.jump({ count = opts_.forward and 1 or -1, float = true })
        -- end
        -- local move_diag_repeat = ts_repeat_move.make_repeatable_move(move_diag)
        --
        -- keymap(move_modes, "]d", function() move_diag_repeat({ forward = true, start = false }) end,
        --     { desc = "Next Diagnostic" })
        -- keymap(move_modes, "[d", function() move_diag_repeat({ forward = false, start = false }) end,
        --     { desc = "Prev Diagnostic" })

        -- Make ]h, [h also repeatable with ; and ,
        local gs = require("gitsigns")
        local next_hunk = function() gs.nav_hunk("next", { target = "all" }) end
        local prev_hunk = function() gs.nav_hunk("prev", { target = "all" }) end
        local next_hunk_repeat, prev_hunk_repeat = make_repeatable_move_pair(next_hunk, prev_hunk)

        keymap(move_modes, "]h", next_hunk_repeat, { desc = "Next Hunk" })
        keymap(move_modes, "[h", prev_hunk_repeat, { desc = "Prev Hunk" })

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
            make_repeatable_move_pair(next_buffer, prev_buffer)
        keymap(move_modes, "]b", next_buffer_repeat, { desc = "Next Buffer" })
        keymap(move_modes, "[b", prev_buffer_repeat, { desc = "Prev Buffer" })

        -- Create ]] and [r for go to refereces under cursor
        local illuminate = require("illuminate")
        local next_rf_repeat, prev_rf_repeat =
            make_repeatable_move_pair(illuminate.goto_next_reference, illuminate.goto_prev_reference)

        keymap(move_modes, "]]", next_rf_repeat, { desc = "Next Reference" })
        keymap(move_modes, "[[", prev_rf_repeat, { desc = "Prev Reference" })

        -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                keymap(move_modes, "]]", next_rf_repeat, { desc = "Next Reference", buffer = buffer })
                keymap(move_modes, "[[", prev_rf_repeat, { desc = "Prev Reference", buffer = buffer })
            end,
        })

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
        local next_qf_repeat, prev_qf_repeat = make_repeatable_move_pair(next_qf, prev_qf)
        keymap(move_modes, "]q", next_qf_repeat, { desc = "Next QuickFix" })
        keymap(move_modes, "[q", prev_qf_repeat, { desc = "Prev QuickFix" })

        local next_loc = function() pcall(vim.api.nvim_command, "lnext") end
        local prev_loc = function() pcall(vim.api.nvim_command, "lprev") end
        local next_loc_repeat, prev_loc_repeat = make_repeatable_move_pair(next_loc, prev_loc)
        keymap(move_modes, "]l", next_loc_repeat, { desc = "Next Location" })
        keymap(move_modes, "[l", prev_loc_repeat, { desc = "Prev Location" })
    end,
}

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

        keymap(modes, "al", function() select("@loop.outer", "textobjects") end, { desc = "outer loop" })
        keymap(modes, "il", function() select("@loop.inner", "textobjects") end, { desc = "inner loop" })

        keymap(modes, "af", function() select("@function.outer", "textobjects") end, { desc = "outer function" })
        keymap(modes, "if", function() select("@function.inner", "textobjects") end, { desc = "inner function" })

        keymap(modes, "ac", function() select("@class.outer", "textobjects") end, { desc = "outer class" })
        keymap(modes, "ic", function() select("@class.inner", "textobjects") end, { desc = "inner class" })

        keymap(modes, "ar", function() select("@return.outer", "textobjects") end, { desc = "outer return" })
        keymap(modes, "ir", function() select("@return.inner", "textobjects") end, { desc = "inner return" })

        -- Swap
        local swap = require("nvim-treesitter-textobjects.swap")

        vim.keymap.set("n", "<leader>csn", function() swap.swap_next("@parameter.inner") end,
            { desc = "Swap with next param" })
        vim.keymap.set("n", "<leader>csp", function() swap.swap_previous("@parameter.inner") end,
            { desc = "Swap with prev param" })

        -- Move
        local move = require("nvim-treesitter-textobjects.move")
        local map = vim.keymap.set
        local move_modes = { "n", "x", "o" }

        -- Goto next start
        map(move_modes, "]a", function() move.goto_next_start("@parameter.outer", "textobjects") end,
            { desc = "Next arg start" })
        map(move_modes, "]f", function() move.goto_next_start("@function.outer", "textobjects") end,
            { desc = "Next func start" })
        map(move_modes, "]e", function() move.goto_next_start("@return.outer", "textobjects") end,
            { desc = "Next return start" })
        map(move_modes, "]c", function() move.goto_next_start("@class.outer", "textobjects") end,
            { desc = "Next class start" })
        map(move_modes, "]j", function() move.goto_next_start("@conditional.outer", "textobjects") end,
            { desc = "Next cond start" })
        map(move_modes, "]l", function() move.goto_next_start("@loop.outer", "textobjects") end,
            { desc = "Next loop start" })

        -- Goto next end
        map(move_modes, "]A", function() move.goto_next_end("@parameter.outer", "textobjects") end)
        map(move_modes, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
        map(move_modes, "]E", function() move.goto_next_end("@return.outer", "textobjects") end)
        map(move_modes, "]C", function() move.goto_next_end("@class.outer", "textobjects") end)
        map(move_modes, "]J", function() move.goto_next_end("@conditional.outer", "textobjects") end)
        map(move_modes, "]L", function() move.goto_next_end("@loop.outer", "textobjects") end)

        -- Goto previous start
        map(move_modes, "[a", function() move.goto_previous_start("@parameter.outer", "textobjects") end)
        map(move_modes, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
        map(move_modes, "[e", function() move.goto_previous_start("@return.outer", "textobjects") end)
        map(move_modes, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end)
        map(move_modes, "[j", function() move.goto_previous_start("@conditional.outer", "textobjects") end)
        map(move_modes, "[l", function() move.goto_previous_start("@loop.outer", "textobjects") end)

        -- Goto previous end
        map(move_modes, "[A", function() move.goto_previous_end("@parameter.outer", "textobjects") end)
        map(move_modes, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)
        map(move_modes, "[E", function() move.goto_previous_end("@return.outer", "textobjects") end)
        map(move_modes, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end)
        map(move_modes, "[J", function() move.goto_previous_end("@conditional.outer", "textobjects") end)
        map(move_modes, "[L", function() move.goto_previous_end("@loop.outer", "textobjects") end)


        -- --TODO: make_repeatable_move_pair
        -- local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
        --
        -- local function make_repeatable_func(fn)
        --     return function()
        --         local _, keys = pcall(fn)
        --         if keys then
        --             local cmd = ('normal! %d%s'):format(vim.v.count1, vim.keycode(keys))
        --             vim.cmd(cmd)
        --         end
        --     end
        -- end
        --
        -- -- Repeat movement with ; and , vim way
        -- vim.keymap.set({ "n", "x", "o" }, ";", make_repeatable_func(ts_repeat_move.repeat_last_move))
        -- vim.keymap.set({ "n", "x", "o" }, ",", make_repeatable_func(ts_repeat_move.repeat_last_move_opposite))
        --
        -- -- Make builtin f, F, t, T also repeatable with ; and ,
        -- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        -- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        -- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        -- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

        -- -- Make ]h, [h also repeatable with ; and ,
        -- local gs = require("gitsigns")
        -- local next = require("repeat-move")
        -- local next_hunk = function() gs.nav_hunk("next", { target = "all" }) end
        -- local prev_hunk = function() gs.nav_hunk("prev", { target = "all" }) end
        -- local next_hunk_repeat, prev_hunk_repeat = next.make_repeatable_move_pair(next_hunk, prev_hunk)
        --
        -- vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat, { desc = "Next Hunk" })
        -- vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat, { desc = "Prev Hunk" })
        --
        -- -- Make ]d, [d also repeatable with ; and ,
        -- local next_diagnostic = function() vim.diagnostic.jump({ count = 1, float = true }) end
        -- local prev_diagnostic = function() vim.diagnostic.jump({ count = -1, float = true }) end
        -- local next_diagnostic_repeat, prev_diagnostic_repeat =
        --     next.make_repeatable_move_pair(next_diagnostic, prev_diagnostic)
        -- vim.keymap.set({ "n", "x", "o" }, "]d", next_diagnostic_repeat, { desc = "Next Diagnostic" })
        -- vim.keymap.set({ "n", "x", "o" }, "[d", prev_diagnostic_repeat, { desc = "Prev Diagnostic" })
        --
        -- -- Make ]b, [b also repeatable with ; and ,
        -- local next_buffer = function()
        --     vim.api.nvim_command("bnext")
        --     vim.api.nvim_command("file")
        -- end
        -- local prev_buffer = function()
        --     vim.api.nvim_command("bprev")
        --     vim.api.nvim_command("file")
        -- end
        -- local next_buffer_repeat, prev_buffer_repeat =
        --     next.make_repeatable_move_pair(next_buffer, prev_buffer)
        -- vim.keymap.set({ "n", "x", "o" }, "]b", next_buffer_repeat, { desc = "Next Buffer" })
        -- vim.keymap.set({ "n", "x", "o" }, "[b", prev_buffer_repeat, { desc = "Prev Buffer" })
        --
        -- -- Create ]] and [r for go to refereces under cursor
        -- local illuminate = require("illuminate")
        -- local next_rf_repeat, prev_rf_repeat =
        --     next.make_repeatable_move_pair(illuminate.goto_next_reference, illuminate.goto_prev_reference)
        --
        -- vim.keymap.set({ "n", "x", "o" }, "]r", next_rf_repeat, { desc = "Next Reference" })
        -- vim.keymap.set({ "n", "x", "o" }, "[r", prev_rf_repeat, { desc = "Prev Reference" })
        --
        -- -- -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        -- -- vim.api.nvim_create_autocmd("FileType", {
        -- --     callback = function()
        -- --         local buffer = vim.api.nvim_get_current_buf()
        -- --         vim.keymap.set({ "n", "x", "o" }, "]]", next_rf_repeat, { desc = "Next Reference", buffer = buffer })
        -- --         vim.keymap.set({ "n", "x", "o" }, "[[", prev_rf_repeat, { desc = "Prev Reference", buffer = buffer })
        -- --     end,
        -- -- })
        --
        -- -- Create ]q, [q for quickfix list and make them repeatable with ; and ,
        -- local check_quickfix_then_run = function(cmd)
        --     local qf = vim.fn.getqflist()
        --     if vim.tbl_isempty(qf) then return end
        --
        --     local qf_idx = vim.fn.getqflist({ idx = 0 }).idx
        --
        --     if qf_idx == 1 and cmd == "cprev" then
        --         vim.api.nvim_command("clast")
        --     elseif qf_idx == #qf and cmd == "cnext" then
        --         vim.api.nvim_command("cfirst")
        --     else
        --         vim.api.nvim_command(cmd)
        --     end
        -- end
        --
        -- local next_qf = function() check_quickfix_then_run("cnext") end
        -- local prev_qf = function() check_quickfix_then_run("cprev") end
        -- local next_qf_repeat, prev_qf_repeat = next.make_repeatable_move_pair(next_qf, prev_qf)
        -- vim.keymap.set({ "n", "x", "o" }, "]q", next_qf_repeat, { desc = "Next QuickFix" })
        -- vim.keymap.set({ "n", "x", "o" }, "[q", prev_qf_repeat, { desc = "Prev QuickFix" })
        --
        -- -- Create ]Q and [Q
        -- local first_qf = function() check_quickfix_then_run("cfirst") end
        -- local last_qf = function() check_quickfix_then_run("clast") end
        -- vim.keymap.set({ "n", "x", "o" }, "[Q", first_qf, { desc = "First QuickFix" })
        -- vim.keymap.set({ "n", "x", "o" }, "]Q", last_qf, { desc = "Last QuickFix" })
    end,
}

local function make_repeatable_move_pair(forward_fn, backward_fn)
  local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

  local general_fn = function(opts_)
    if opts_.forward then
      forward_fn()
    else
      backward_fn()
    end
  end

  local forward = function()
    ts_repeat_move.last_move = { func = general_fn, opts = { forward = true }, additional_args = {} }
    forward_fn()
  end

  local backward = function()
    ts_repeat_move.last_move = { func = general_fn, opts = { forward = false }, additional_args = {} }
    backward_fn()
  end

  return forward, backward
end

return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gv", "<cmd>CodeDiff<CR>", desc = "Open codediff (working tree)" },
    { "<leader>gf", "<cmd>CodeDiff history %<CR>", desc = "File history (current file)" },
    { "<leader>gF", "<cmd>CodeDiff history<CR>", desc = "Branch history" },
    { "<leader>gm", "<cmd>CodeDiff ...<CR>", desc = "Diff vs main (merge-base)" },
  },
  opts = {
    diff = {
      layout = "side-by-side",
      filler_text = "╱",
      disable_inlay_hints = true,
      max_computation_time_ms = 5000,
    },
    explorer = {
      position = "left",
      width = 40,
      view_mode = "tree",
      flatten_dirs = true,
      initial_focus = "explorer",
    },
    keymaps = {
      view = {
        quit = "q",
        toggle_explorer = "<leader>b",
        focus_explorer = "<leader>e",
        -- disabled: overridden by repeatable wrappers in CodeDiffOpen autocmd
        next_hunk = false,
        prev_hunk = false,
        next_file = false,
        prev_file = false,
        diff_get = "do",
        diff_put = "dp",
        toggle_layout = "t",
        toggle_compact = "gc",
        toggle_stage = "-",
        stage_hunk = "hs",
        discard_hunk = "hr",
        show_help = "g?",
      },
      explorer = {
        select = "<CR>",
        refresh = "R",
        toggle_view_mode = "i",
        stage_all = "S",
        unstage_all = "U",
        restore = "X",
        toggle_staged = "gs",
        toggle_changes = "gu",
      },
    },
  },
  config = function(_, opts)
    require("codediff").setup(opts)

    local navigation = require("codediff.ui.view.navigation")

    local next_hunk_rep, prev_hunk_rep = make_repeatable_move_pair(navigation.next_hunk, navigation.prev_hunk)
    local next_file_rep, prev_file_rep = make_repeatable_move_pair(navigation.next_file, navigation.prev_file)

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffOpen",
      callback = function(event)
        local tabpage = event.data.tabpage
        if not tabpage then return end
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
          local bufnr = vim.api.nvim_win_get_buf(win)
          local function map(lhs, fn, desc)
            vim.keymap.set("n", lhs, fn, { buffer = bufnr, desc = desc, nowait = true, silent = true })
          end
          map("]h", next_hunk_rep, "Next hunk (repeatable)")
          map("[h", prev_hunk_rep, "Prev hunk (repeatable)")
          map("]f", next_file_rep, "Next file (repeatable)")
          map("[f", prev_file_rep, "Prev file (repeatable)")
        end
      end,
    })
  end,
}
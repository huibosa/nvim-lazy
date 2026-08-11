local function patch_navigation_for_repeat()
  local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
  local navigation = require("codediff.ui.view.navigation")

  -- Mirror nvim-treesitter-textobjects' repeatable-move-pair pattern: the
  -- dispatcher stored on `last_move` branches on `opts.forward`, so `;`
  -- repeats the original direction and `,` repeats the opposite one. A
  -- direction-hardcoded closure (the previous approach) made `;` and `,`
  -- always repeat the same way, since `repeat_last_move_opposite` only flips
  -- `opts.forward` — which the closure ignored.
  local function make_repeatable_pair(forward_fn, backward_fn)
    local dispatch = function(opts, ...)
      if opts.forward then
        forward_fn(...)
      else
        backward_fn(...)
      end
    end

    local repeatable_forward = function(...)
      ts_repeat_move.last_move = { func = dispatch, opts = { forward = true }, additional_args = { ... } }
      return forward_fn(...)
    end

    local repeatable_backward = function(...)
      ts_repeat_move.last_move = { func = dispatch, opts = { forward = false }, additional_args = { ... } }
      return backward_fn(...)
    end

    return repeatable_forward, repeatable_backward
  end

  -- Read the originals before reassigning so the wrappers call the real
  -- moves instead of recursing into themselves.
  navigation.next_hunk, navigation.prev_hunk = make_repeatable_pair(navigation.next_hunk, navigation.prev_hunk)
  navigation.next_file, navigation.prev_file = make_repeatable_pair(navigation.next_file, navigation.prev_file)
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
        next_hunk = "]h",
        prev_hunk = "[h",
        next_file = "]f",
        prev_file = "[f",
        diff_get = "do",
        diff_put = "dp",
        toggle_layout = "t",
        toggle_compact = "zc",
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
    patch_navigation_for_repeat()
  end,
}
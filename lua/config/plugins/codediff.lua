local function patch_navigation_for_repeat()
  local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
  local navigation = require("codediff.ui.view.navigation")

  local orig_next_hunk = navigation.next_hunk
  local orig_prev_hunk = navigation.prev_hunk
  local orig_next_file = navigation.next_file
  local orig_prev_file = navigation.prev_file

  navigation.next_hunk = function()
    ts_repeat_move.last_move = { func = function() navigation.next_hunk() end, opts = { forward = true }, additional_args = {} }
    return orig_next_hunk()
  end

  navigation.prev_hunk = function()
    ts_repeat_move.last_move = { func = function() navigation.prev_hunk() end, opts = { forward = false }, additional_args = {} }
    return orig_prev_hunk()
  end

  navigation.next_file = function()
    ts_repeat_move.last_move = { func = function() navigation.next_file() end, opts = { forward = true }, additional_args = {} }
    return orig_next_file()
  end

  navigation.prev_file = function()
    ts_repeat_move.last_move = { func = function() navigation.prev_file() end, opts = { forward = false }, additional_args = {} }
    return orig_prev_file()
  end
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
    patch_navigation_for_repeat()
  end,
}
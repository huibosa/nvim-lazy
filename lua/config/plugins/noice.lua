return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        progress = { enabled = true, },
        hover = { enabled = false, },
        signature = { enabled = false, },
      },

      popupmenu = { enabled = true },

      cmdline = {
        enabled = true,
        view = "cmdline",
        format = {
          cmdline = { pattern = "^:", icon = ">", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "Search^", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "Searchv", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "Lua", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
        }
      },
    })
  end
}

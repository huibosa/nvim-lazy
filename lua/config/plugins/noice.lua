return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("noice").setup({
      cmdline = {
        enabled = true,
        view = "cmdline",
        format = {
          cmdline = { pattern = "^:", icon = ">", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "Search ^", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "Search v", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "Lua", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
        }
      },

      views = {
        mini = { timeout = 3000, },
        hover = {
          border = { style = vim.g.window_borders, padding = { 0, 0 } },
          position = { row = 2, col = 1 },
        }
      }
    })

    vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true })

    vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true })
  end
}

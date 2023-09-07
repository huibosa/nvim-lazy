return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        ensure_installed = {
          "json",
          "markdown",
          "markdown_inline",
          "dockerfile",
          "gitignore",
          "go",
          "c",
          "cpp",
          "bash",
          "lua",
          "csv",
          "python",
        },

        auto_install = true,

        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          addtional_vim_regex_highlighting = false,
        },

        indent = { enable = true },
      })
    end,
  },
}

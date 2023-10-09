return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            mode = "n",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            c = { "clangformat" },
            cpp = { "clangformat" },
            elixir = { "mix" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            lua = { "stylua" },
        },
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },
    },
    config = function(_, opts)
        local util = require("conform.util")
        util.add_formatter_args(require("conform.formatters.shfmt"), { "-i", "4", "--space-redirects" })

        require("conform").setup(opts)
    end,
}

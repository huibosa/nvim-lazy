return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<LEADER>cf",
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            mode = "n",
            desc = "Format",
        },
    },
    config = function()
        local util = require("conform.util")
        util.add_formatter_args(require("conform.formatters.shfmt"), { "-i", "4", "--space-redirects" })

        local slow_format_filetypes = {}
        require("conform").setup({
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                python = { "ruff_fix", "ruff_format" },
                sh = { "shfmt" },
                lua = { "stylua" },
            },
            format_on_save = function(bufnr)
                if slow_format_filetypes[vim.bo[bufnr].filetype] then return end
                local function on_format(err)
                    if err and err:match("timeout$") then slow_format_filetypes[vim.bo[bufnr].filetype] = true end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
            end,

            format_after_save = function(bufnr)
                if not slow_format_filetypes[vim.bo[bufnr].filetype] then return end
                return { lsp_fallback = true }
            end,
        })
    end,
}

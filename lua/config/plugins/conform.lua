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
            formatters = {
                prettier = {
                    prepend_args = { "--use-tabs", "--tab-width", "2", "--print-width", "9999" },
                },
            },
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports", },
                sh = { "shfmt" },
                lua = { "stylua" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
            },
            format_on_save = function(bufnr)
                local ft = vim.bo[bufnr].filetype
                -- Let Claude Code own TS/JS style; format manually with <leader>cf
                if ft == "typescript" or ft == "typescriptreact"
                    or ft == "javascript" or ft == "javascriptreact" then
                    return
                end
                if ft == "json" or ft == "jsonc" then return end
                if slow_format_filetypes[ft] then return end
                local function on_format(err)
                    if err and err:match("timeout$") then slow_format_filetypes[ft] = true end
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

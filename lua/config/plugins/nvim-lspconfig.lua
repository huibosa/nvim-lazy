return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")

        -- Declare the client capabilities, which announce to the LSP server what
        -- features the editor can support.
        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        local hover = vim.lsp.buf.hover
        vim.lsp.buf.hover = function()
            return hover({
                border = vim.g.window_borders,
            })
        end

        local signature_help = vim.lsp.buf.signature_help
        vim.lsp.buf.signature_help = function()
            return signature_help({
                border = vim.g.window_borders,
            })
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local bufnr = ev.buf

                local keymap = function(mode, lhs, rhs, opts_)
                    opts_ = opts_ or {}
                    opts_.silent = true
                    opts_.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts_)
                end

                -- keymap(
                --     "n",
                --     "<LEADER>lh",
                --     function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end
                -- )

                keymap("i", "<C-l>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
                keymap("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
                keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
                keymap("n", "grt", vim.lsp.buf.type_definition, { desc = "Type Definitions" })
                keymap("n", "grf", vim.lsp.buf.format, { desc = "Format document" })
                keymap("n", "<LEADER>cwa", vim.lsp.buf.add_workspace_folder, { desc = "Add Folder" })
                keymap("n", "<LEADER>cwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Folder" })
                keymap(
                    "n",
                    "<LEADER>cwl",
                    "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    { desc = "List Folders" }
                )

                -- Set some key bindings conditional on server capabilities
                -- Disable ruff hover feature in favor of Pyright
                if client.name == "ruff" then client.server_capabilities.hoverProvider = false end

                -- Disable pyright formating, use ruff
                if client.name == "pyright" then client.server_capabilities.documentFormattingProvider = false end
            end,
        })

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("ruff")
        vim.lsp.enable("rust_analyzer")
        vim.lsp.enable("clangd")
        vim.lsp.enable("gopls")
        vim.lsp.enable("bashls")
    end,
}

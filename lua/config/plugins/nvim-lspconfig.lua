return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
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

        -- A mapping from lsp server name to the executable name
        local enabled_lsp_servers = {
            lua_ls = "lua-language-server",
            rust_analyzer = "rust-analyzer",
            clangd = "clangd",
            bashls = "bash-language-server",
            gopls = "gopls",
            ruff = "ruff",
            -- ty = "ty",
            -- pyright = "delance-langserver",
            basedpyright = "basedpyright-langserver",
            -- pyrefly = "pyrefly",
        }

        local utils = require("utils")

        for server_name, lsp_executable in pairs(enabled_lsp_servers) do
            if utils.executable(lsp_executable) then
                vim.lsp.enable(server_name)
            else
                local msg = string.format(
                    "Executable '%s' for server '%s' not found! Server will not be enabled",
                    lsp_executable,
                    server_name
                )
                vim.notify(msg, vim.log.levels.WARN, { title = "Nvim-config" })
            end
        end
    end,
}

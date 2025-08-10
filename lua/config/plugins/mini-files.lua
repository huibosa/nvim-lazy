return {
    "echasnovski/mini.files",
    cmd = { "MiniFiles" },
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        local mini = require("mini.files")
        vim.api.nvim_create_user_command("MiniFiles", function()
            mini.open()
        end, {})
    end
}

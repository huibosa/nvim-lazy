return {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
        local paths = {}

        ---@diagnostic disable-next-line: undefined-field
        if vim.loop.os_uname().sysname == "Darwin" then
            table.insert(paths, "~/Library/Application Support/Code/User/snippets")
        else
            table.insert(paths, "~/winhome/AppData/Roaming/Code/User/snippets")
        end

        require("luasnip.loaders.from_vscode").lazy_load({ paths = paths })
    end,
}

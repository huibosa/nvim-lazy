return {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
        local path = ""
        if vim.loop.os_uname().sysname == "Darwin" then
            path = "~/Library/Application Support/Code/User/snippets"
        else
            path = "~/winhome/AppData/Code/User/snippets"
        end

        require("luasnip.loaders.from_vscode").lazy_load({ paths = path })
    end,
}

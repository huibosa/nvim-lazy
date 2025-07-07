return {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath("config"),
                },
            },
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            hint = {
                enable = true,
            },
        },
    },
}

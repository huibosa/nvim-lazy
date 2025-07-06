return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
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
    single_file_surpport = true,
}

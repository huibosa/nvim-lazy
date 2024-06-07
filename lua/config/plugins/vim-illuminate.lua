return {
    "RRethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = function()
        require("illuminate").configure(
            -- default configuration
            require("illuminate").configure({
                delay = 100,
            })
        )
    end,
}

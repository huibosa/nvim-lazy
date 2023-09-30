return {
    "RRethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("illuminate").configure(
            -- default configuration
            require("illuminate").configure({
                delay = 300,
            })
        )
    end,
}

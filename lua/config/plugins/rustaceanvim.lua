return {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
        vim.g.rustaceanvim = {
            tools = {
                float_win_config = {
                    border = 'bold',
                }
            },
        }
    end,
}

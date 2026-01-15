return {
    'daliusd/incr.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    opts = {
        incr_key = '<CR>',
        decr_key = '<BS>',
    }
}

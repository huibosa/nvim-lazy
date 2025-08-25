return {
    "elanmed/fzf-lua-frecency.nvim",
    event = "VeryLazy",
    dependencies = { "ibhagwan/fzf-lua" },
    keys = {
        {
            "<C-p>",
            function() require("fzf-lua-frecency").frecency() end,
            desc = "Files",
        },
    },
    config = function()
        require("fzf-lua-frecency").setup({
            cwd_only = true,
        })
    end
}

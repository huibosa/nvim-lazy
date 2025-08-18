return {
    "mbbill/undotree",
    keys = { "<LEADER>tu" },
    config = function()
        vim.keymap.set('n', '<LEADER>tu', vim.cmd.UndotreeToggle)

        if vim.fn.has("persistent_undo") == 1 then
            local target_path = vim.fn.stdpath('data') .. '/undodir//'

            -- create the directory if it doesn't exist
            if vim.uv.fs_stat(target_path) == 0 then
                vim.fn.mkdir(target_path, "p", "0700")
            end

            vim.o.undodir = target_path
            vim.o.undofile = true
        end


        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_WindowLayout = 4
    end
}

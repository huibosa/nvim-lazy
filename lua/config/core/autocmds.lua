-- From vim defaults.vim
-- ---
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
vim.api.nvim_create_autocmd("BufRead", {
    callback = function(opts)
        vim.api.nvim_create_autocmd("BufWinEnter", {
            once = true,
            buffer = opts.buf,
            callback = function()
                local ft = vim.bo[opts.buf].filetype
                local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
                if
                    not (ft:match("commit") and ft:match("rebase"))
                    and last_known_line > 1
                    and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
                then
                    vim.api.nvim_feedkeys([[g`"]], "nx", false)
                end
            end,
        })
    end,
})

-- highlight yanked region, see `:h lua-highlight`
local yank_group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    group = yank_group,
    callback = function() vim.highlight.on_yank({ higroup = "HighlightedyankRegion", timeout = 500 }) end,
})

-- Keep cursor stays in position after visual yank
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    pattern = "*",
    group = yank_group,
    callback = function() vim.g.current_cursor_pos = vim.fn.getcurpos() end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    group = yank_group,
    callback = function()
        if vim.v.event.operator == "y" then vim.fn.setpos(".", vim.g.current_cursor_pos) end
    end,
})

-- Auto-create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
    callback = function(ev)
        local dir = vim.fn.fnamemodify(ev.file, ":p:h")
        local res = vim.fn.isdirectory(dir)

        if res == 0 then vim.fn.mkdir(dir, "p") end
    end,
})

-- Automatically reload the file if it is changed outside of Nvim, see https://unix.stackexchange.com/a/383044/221410.
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
vim.api.nvim_create_augroup("auto_read", { clear = true })

vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
    pattern = "*",
    group = "auto_read",
    callback = function()
        vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
    pattern = "*",
    group = "auto_read",
    callback = function()
        if vim.fn.getcmdwintype() == "" then vim.cmd([[checktime]]) end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "py", "sh" },
    callback = function()
        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
    end,
})

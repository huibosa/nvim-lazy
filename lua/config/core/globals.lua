local utils = require("utils")

------------------------------------------------------------------------
--                         builtin variables                          --
------------------------------------------------------------------------
vim.g.is_win = (utils.has("win32") or utils.has("win64")) and true or false
vim.g.is_linux = (utils.has("unix") and (not utils.has("macunix"))) and true or false
vim.g.is_mac = utils.has("macunix") and true or false

-- Set up backup directory
vim.g.backupdir = vim.fn.expand(vim.fn.stdpath("data") .. "/backup//")
--opt.backupdir = vim.g.backupdir

vim.g.loaded_perl_provider = 0      -- Disable perl provider
vim.g.loaded_ruby_provider = 0      -- Disable ruby provider
vim.g.loaded_node_provider = 0      -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

-- Custom mapping <LEADER> (see `:h mapleader` for more info)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = "l"

-- Disable loading certain plugins
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_pythonx_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1

vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1

vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1

vim.g.loaded_2html_plugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_shada_plugin = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwSettings = 1

vim.g.loaded_fzf = 1
vim.g.loaded_fzf_vim = 1

vim.g.loaded_tutor = 1
vim.g.loaded_tutor_mode_plugin = 1

vim.g.loaded_spellfile_plugin = 1

vim.g.loaded_syntax = 1
vim.g.loaded_synmenu = 1
vim.g.loaded_optwin = 1
vim.g.loaded_compiler = 1
vim.g.loaded_bugreport = 1

-- vim.g.loaded_ftplugin = 1
-- vim.g.did_ftplugin = 1
-- vim.g.skip_loading_ftplugin = 1

vim.g.did_install_default_menus = 1
vim.g.loaded_sql_completion = 1
vim.g.loaded_spec = 1
vim.g.loaded_man = 1
vim.g.load_black = 1
vim.g.loaded_gtags = 1
vim.g.loaded_gtags_cscope = 1

vim.g.window_borders = {
    { "┏", "FloatBorder" },
    { "━", "FloatBorder" },
    { "┓", "FloatBorder" },
    { "┃", "FloatBorder" },
    { "┛", "FloatBorder" },
    { "━", "FloatBorder" },
    { "┗", "FloatBorder" },
    { "┃", "FloatBorder" },
}

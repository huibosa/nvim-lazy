return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "ruff.toml",
        ".ruff.toml",
    },
    init_options = {
        -- the settings can be found here: https://docs.astral.sh/ruff/editors/settings/
        settings = {
            organizeImports = true,
        },
    },
}

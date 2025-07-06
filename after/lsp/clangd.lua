return {
    cmd = {
        "clangd",
        "--completion-style=detailed",
        "--header-insertion=never",
        "--function-arg-placeholders=1",
    },
    filetypes = { "c", "cpp", "cc", "h", "hpp" },
    flags = {
        debounce_text_changes = 500,
    },
}

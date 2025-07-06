return {
    cmd = {
        "rustup",
        "run",
        "stable",
        "rust-analyzer",
    },
    filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = {
                    "--",
                    "--no-deps",
                    "-Dclippy::correctness",
                    "-Dclippy::complexity",
                    "-Wclippy::perf",
                    "-Wclippy::pedantic",
                },
            },
            procMacro = {
                enable = true,
                ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                },
            },
        },
    },
}

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        python = {
            require("formatter.filetypes.python").black,
        },
        typescript = {
            require("formatter.filetypes.typescript").prettier,
        },
        typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier,
        },
        javascript = {
            require("formatter.filetypes.javascript").prettier,
        },
        javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettier,
        },
        css = {
            require("formatter.filetypes.css").prettier,
        },
        scss = {
            require("formatter.filetypes.css").prettier,
        },
        json = {
            require("formatter.filetypes.json").prettier,
        },
        jsonc = {
            require("formatter.filetypes.json").prettier,
        },
        rust = {
            require("formatter.filetypes.rust").rustfmt,
        },
        c = {
            require("formatter.filetypes.c").clangformat,
        },
        cpp = {
            require("formatter.filetypes.cpp").clangformat,
        },
        cmake = {
            require("formatter.filetypes.cmake").cmakeformat,
        },
        svelte = {
            require("formatter.filetypes.svelte").prettier,
        },
    },
})

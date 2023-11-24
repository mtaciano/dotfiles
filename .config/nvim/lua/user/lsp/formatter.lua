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
    },
})

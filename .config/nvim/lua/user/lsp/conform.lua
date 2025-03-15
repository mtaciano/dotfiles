require("conform").setup({
    -- Map of filetype to formatters
    formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        python = { "ruff_organize_imports", "ruff_format" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "cmake_format" },
        go = { "goimports", "gofmt" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        svelte = { "prettierd" },
        typst = { "typstyle" },
        gitcommit = { "commitmsgfmt" },
        fish = { "fish_indent" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace", "trim_newlines" },
    },
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
})

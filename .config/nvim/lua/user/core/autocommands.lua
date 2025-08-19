local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight yanked text for 500ms using the "Visual" highlight group
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = "500",
        })
    end,
})

-- Don't auto comment new lines
-- autocmd("BufEnter", {
--     pattern = { "*" },
--     command = "set fo-=c fo-=r fo-=o",
-- })

-- Set colorcolumn for some languages
autocmd("Filetype", {
    pattern = { "rust" },
    command = "set colorcolumn=100",
})
autocmd("Filetype", {
    pattern = { "python" },
    command = "set colorcolumn=88",
})

-- Set textwidth for some languages
autocmd("Filetype", {
    pattern = { "rust" },
    command = "set textwidth=100",
})
autocmd("Filetype", {
    pattern = { "python" },
    command = "set textwidth=88",
})

-- Spell-check Markdown files, Git Commit Messages and Typst documents
-- autocmd("Filetype", {
--     pattern = { "markdown" },
--     command = "setlocal spell",
-- })
autocmd("Filetype", {
    pattern = { "gitcommit" },
    command = "setlocal spell",
})
autocmd("Filetype", {
    pattern = { "typst" },
    command = "setlocal spell",
})

-- Wrap lines when writing a typst document
autocmd("Filetype", {
    pattern = { "typst" },
    command = "set wrap",
})

-- Close Netrw when selecting a file
autocmd("Filetype", {
    pattern = { "netrw" },
    command = "setlocal bufhidden=wipe",
})

-- Format buffer
autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

-- Make treesitter work
autocmd("FileType", {
    pattern = require("nvim-treesitter").get_installed(),
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
})

-- Keep the cursor style when exiting
autocmd({ "VimEnter", "VimResume" }, {
    pattern = { "*" },
    command = "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,"
        .. "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
        .. "sm:block-blinkwait175-blinkoff150-blinkon175",
})
autocmd({ "VimLeave", "VimSuspend" }, {
    pattern = { "*" },
    command = "set guicursor=a:block-blinkon800",
})

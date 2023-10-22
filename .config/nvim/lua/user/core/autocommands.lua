local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
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

-- Dont auto comment new lines
autocmd("BufEnter", {
    pattern = { "*" },
    command = "set fo-=c fo-=r fo-=o",
})

-- Always remove trailing whitespace
autocmd("BufWritePre", {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Set colorcolumn for some languages
autocmd("Filetype", {
    pattern = { "rust" },
    command = "set colorcolumn=100",
})
autocmd("Filetype", {
    pattern = { "python" },
    command = "set colorcolumn=88",
})

-- Close Netrw when selecting a file
autocmd("Filetype", {
    pattern = { "netrw" },
    command = "setlocal bufhidden=wipe",
})

-- Format on save
autocmd("BufWritePost", {
    pattern = { "*" },
    command = "FormatWrite",
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

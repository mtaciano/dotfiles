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
autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Set colorcolumn
autocmd("Filetype", {
    pattern = { "rust" },
    command = "set colorcolumn=100",
})
autocmd("Filetype", {
    pattern = { "python" },
    command = "set colorcolumn=88",
})

-- Format on save
autocmd("BufWritePost", {
    pattern = { "*" },
    command = "FormatWrite",
})

-- Highlight yanked text for 250ms using the "Visual" highlight group
vim.cmd([[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({ higroup="Visual", timeout=250 })
    augroup END
]])

-- Always remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Change max line width when in a rust file
vim.cmd([[
    augroup cc
    autocmd FileType rust set colorcolumn=100
    augroup END
]])

-- Format on save
vim.cmd([[ autocmd BufWritePost * FormatWrite ]])

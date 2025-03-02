require("leap")

vim.keymap.set({ "n" }, "s", "<plug>(leap)")
vim.keymap.set({ "x" }, "z", "<plug>(leap)")
vim.keymap.set({ "o" }, "z", "<plug>(leap-forward)")
vim.keymap.set({ "o" }, "Z", "<plug>(leap-backward)")

vim.keymap.set({ "n" }, "gs", "<plug>(leap-from-window)")
vim.keymap.set({ "x", "o" }, "gz", "<plug>(leap-from-window)")

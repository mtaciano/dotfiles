local keymap = vim.keymap
local builtin = require("telescope.builtin")

keymap.set(
    "n",
    "<Leader>ff",
    builtin.find_files,
    { desc = "File Picker (respects .gitignore)" }
)
keymap.set("n", "<Leader>b", builtin.buffers, { desc = "Manage Buffers" })
keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Grep CWD" })
keymap.set("n", "<Leader>fm", builtin.marks, { desc = "List Marks" })

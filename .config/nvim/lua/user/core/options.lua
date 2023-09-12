local g = vim.g -- Global variables
local opt = vim.opt -- Set options
local keymap = vim.keymap -- Keymap options
local builtin = require("telescope.builtin")

-- Global options
keymap.set("n", "<Space>", "<Nop>") -- First we remove the keybind
g.mapleader = " " -- Then we bind it to the leader

-- Set options
opt.mouse = "a" -- Enable mouse support
opt.completeopt = "menu,menuone,noselect" -- Completion modes
opt.cursorline = true -- Hightlight the line of the cursor
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.number = true -- Show line number
opt.relativenumber = true -- Make the line number relative
opt.showmatch = true -- Highlight matching parenthesis
opt.colorcolumn = "80" -- Line lenght marker at 80 columns
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.background = "dark" -- Use dark theme
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines
opt.list = true -- Show hidden characters
opt.listchars = { -- What characters to show
    eol = "↓",
    tab = ">-",
    space = "·",
    trail = "!",
}
opt.matchpairs:append({ "<:>" }) -- Add angle brackets to matching pairs
opt.timeout = true -- Wait for a sequence to complete
opt.timeoutlen = 1000 -- Time in ms to wait for a mapped sequence to complete
opt.scrolloff = 4 -- Number of lines to keep above and below the cursor

-- Keymaps
keymap.set(
    "x",
    "<Leader>p",
    '"_dP',
    { desc = "Paste and don't change register" }
)
keymap.set("n", "<C-d>", "<C-d>zz") -- Center the cursor when using <C-d>
keymap.set("n", "<C-u>", "<C-u>zz") -- Center the cursor when using <C-u>
keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "File Picker" })
keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Manage Buffers" })
keymap.set(
    "n",
    "<Leader>fgf",
    builtin.git_files,
    { desc = "File Picker (respects .gitignore)" }
)
keymap.set("n", "<Leader>flg", builtin.live_grep, { desc = "Grep CWD" })
keymap.set("n", "<Leader>fm", builtin.man_pages, { desc = "Man Pages" })

local g = vim.g -- Global variables
local opt = vim.opt -- Set options
local o = vim.o -- Set options
local keymap = vim.keymap -- Keymap options
local cmd = vim.cmd -- Commands
local diagnostic = vim.diagnostic -- Diagnostics

-- Global options
keymap.set("n", "<Space>", "<Nop>") -- First we remove the keybind
g.mapleader = " " -- Then we bind it to the leader

-- Set options
opt.mouse = "a" -- Enable mouse support
opt.completeopt = "menu,menuone,noselect" -- Completion modes
opt.cursorline = true -- Highlight the line of the cursor
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.number = true -- Show line number
opt.relativenumber = true -- Make the line number relative
opt.showmatch = true -- Highlight matching parenthesis
opt.colorcolumn = "80" -- Line length marker at 80 columns
opt.textwidth = 80 -- Set text width to 80 columns
opt.wrap = false -- Do not wrap lines
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.background = "dark" -- Use dark theme
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Auto indent new lines
opt.list = true -- Show hidden characters
opt.listchars = { -- What characters to show
    eol = "↓",
    tab = ">-",
    space = "·",
    trail = "!",
}
opt.undofile = true -- Persistent undo operations
opt.matchpairs:append({ "<:>" }) -- Add angle brackets to matching pairs
opt.timeout = true -- Wait for a sequence to complete
opt.timeoutlen = 1000 -- Time in ms to wait for a mapped sequence to complete
opt.scrolloff = 2 -- Number of lines to keep above and below the cursor
-- Check word spelling in comments and strings, I enable it only when I'm
-- writing documentation since it has a lot of false positives
opt.spell = false
opt.spelllang = "en_us,pt_br" -- What languages to check the spelling
opt.formatoptions:remove("t") -- Don't auto-wrap text
o.formatexpr = "v:lua.require('conform').formatexpr()" -- Use conform for formatting

diagnostic.config({ virtual_text = true }) -- Enable virtual diagnostic text

-- Commands
cmd.syntax("off") -- Disable syntax (handled by treesitter)

-- Keymaps
keymap.set(
    "x",
    "<Leader>p",
    '"_dP',
    { desc = "Paste and don't change register" }
)
keymap.set(
    "n",
    "<C-d>",
    "<C-d>zz",
    { desc = "Center the cursor when using <C-d>" }
)
keymap.set(
    "n",
    "<C-u>",
    "<C-u>zz",
    { desc = "Center the cursor when using <C-u>" }
)
keymap.set("n", "n", "nzz", { desc = "Center search results" })
keymap.set("", "H", "^", { desc = "Go to the first non-blank char" })
keymap.set("", "L", "$", { desc = "Go to the last non-blank char" })
keymap.set("!", "<C-H>", "<C-w>", { desc = "Delete word" })

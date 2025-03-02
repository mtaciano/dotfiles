-- Plugins
require("user.plugins")

-- Treesitter
require("user.treesitter")

-- Surround
require("user.surround")

-- Leap
require("user.leap")

-- Git
require("user.gitsigns")

-- Telescope
require("user.telescope")

-- Highlights
require("user.highlights")

-- LSP
require("user.lsp.lazydev") -- Has to load before nvim-lspconfig
require("user.lsp.signature")
require("user.lsp.mason")
require("user.lsp.lspconfig")
require("user.lsp.formatter")
require("user.lsp.dap")

-- User configuration
require("user.statusline")
require("user.core.colorscheme")
require("user.core.options")
require("user.core.autocommands")

-- Which key
require("user.which-key")

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

-- LSP
require("user.lsp.signature")
require("user.lsp.mason")
require("user.lsp.lspconfig")
require("user.lsp.conform")
require("user.lsp.dap")

-- User configuration
require("user.statusline")
require("user.core.colorscheme")
require("user.core.options")
require("user.core.autocommands")

-- Highlights
require("user.colorizer") -- Has to load after core.options

-- Which key
require("user.which-key")

-- Plugins
require("user.plugins")

-- Treesitter
require("user.treesitter")

-- Surround
require("user.surround")

-- Git
require("user.gitsigns")

-- Telescope
require("user.telescope")

-- LSP
require("user.lsp.signature")
require("user.lsp.mason")
require("user.lsp.lspconfig")
require("user.lsp.formatter")

-- User configuration
require("user.core.colorscheme")
require("user.statusline")
require("user.core.options")
require("user.core.autocommands")

-- Which key
require("user.which-key")

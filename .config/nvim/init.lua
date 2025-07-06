-- User configuration (need to be loaded first)
require("user.core.options")

-- Plugins
require("user.lazy")

-- Treesitter
require("user.treesitter")

-- Load autocommands after treesitter
require("user.core.autocommands")

-- Surround
require("user.surround")

-- Leap
require("user.leap")

-- Git
require("user.gitsigns")

-- Telescope
require("user.telescope")

-- LSP
-- require("user.lsp.signature")
require("user.lsp.mason")
require("user.lsp.lspconfig")
require("user.lsp.conform")
require("user.lsp.dap")

-- User configuration
require("user.statusline")
require("user.core.buffers")
require("user.core.colorscheme")

-- Highlights
require("user.colorizer") -- Has to load after core.options

-- Which key
require("user.which-key")

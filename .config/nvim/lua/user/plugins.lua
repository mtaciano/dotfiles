-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
    { -- Colorscheme
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- Make sure we load this during startup
        priority = 1000, -- Load this before all the other start plugins
    },
    { -- LSP manager
        "williamboman/mason.nvim",
        lazy = false, -- It's not recommended to lazy load mason
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig", -- LSP Support
            "jay-babu/mason-nvim-dap.nvim",
            "mfussenegger/nvim-dap", -- DAP Support
        },
    },
    { -- DAP UI
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },
    { "mhartington/formatter.nvim" }, -- Formatting
    { "brenoprata10/nvim-highlight-colors" }, -- Show highlight colors
    { -- Code completion
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-cmdline",
            "ray-x/lsp_signature.nvim",
        },
    },
    { -- File explorer
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
            },
        },
    },
    { "tpope/vim-fugitive" }, -- Git wrapper
    { "echasnovski/mini.nvim" }, -- Statusline
    { -- Keybindings menu
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    { -- Git signs
        "lewis6991/gitsigns.nvim",
    },
    { -- Easier surround commands
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
    },
})

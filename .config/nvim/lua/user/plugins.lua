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
    { -- Color scheme
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
    { -- Formatting
        "stevearc/conform.nvim",
        opts = {},
    },
    { "norcalli/nvim-colorizer.lua" }, -- Show highlight colors
    { -- Code completion
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "ray-x/lsp_signature.nvim",
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { -- Markdown preview in the browser
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
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
    { -- File browser
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },
    { "tpope/vim-fugitive" }, -- Git wrapper
    { "echasnovski/mini.nvim" }, -- Status line
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
    {
        "ggandor/leap.nvim",
        dependencies = {
            "tpope/vim-repeat",
        },
    },
})

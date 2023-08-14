-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- Latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
    -- The colorscheme should be available when starting Neovim
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- Make sure we load this during startup
        priority = 1000, -- Load this before all the other start plugins
    },
    -- LSP manager
    {
        "williamboman/mason.nvim",
        lazy = false, -- It's not recommended to lazy load mason
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    -- Formatting
    { "mhartington/formatter.nvim" },
    -- Code completion
    {
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
    -- File explorer
    {
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
    -- Git wrapper
    { "tpope/vim-fugitive" },
    -- Statusline
    { "echasnovski/mini.nvim" },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
})

-- LSP manager
return {
    "mason-org/mason.nvim",
    lazy = false, -- It's not recommended to lazy load mason
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig", -- LSP Support
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap", -- DAP Support
    },
}

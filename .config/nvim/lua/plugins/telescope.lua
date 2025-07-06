-- File explorer
return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            build = ":TSUpdate",
        },
    },
}

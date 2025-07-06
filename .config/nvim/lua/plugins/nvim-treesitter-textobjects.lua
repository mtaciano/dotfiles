-- Text objects for motions (like if and af)
return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter",
            lazy = false,
            branch = "main",
            build = ":TSUpdate",
        },
    },
}

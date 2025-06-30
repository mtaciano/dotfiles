-- Text objects for motions (like if and af)
return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
        },
    },
}

-- require("nvim-surround").setup()
require("mini.surround").setup({
    custom_surroundings = {
        -- Make `B` insert braces.
        ["B"] = {
            input = { { "%b{}", "%b()", "%[]" }, "^.().*().$" },
            output = { left = "{", right = "}" },
        },
    },
})
vim.keymap.set({ "n", "x" }, "s", "<Nop>") -- Avoid deleting using `s`

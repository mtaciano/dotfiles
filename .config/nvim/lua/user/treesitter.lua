local langs = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "doxygen",
    "editorconfig",
    "fish",
    "git_config",
    "gitcommit",
    "gitignore",
    "go",
    "html",
    "hyprlang",
    "ini",
    "java",
    "javadoc",
    "javascript",
    "jinja",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "ruby",
    "rust",
    "requirements",
    "sql",
    "ssh_config",
    "svelte",
    "swift",
    "tmux",
    "toml",
    "tsx",
    "typescript",
    "typst",
    "vim",
    "xml",
    "yaml",
    "zig",
}
require("nvim-treesitter").install(langs)

require("nvim-treesitter-textobjects").setup({
    select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = {
                query = "@class.inner",
                desc = "Select inner part of a class region",
            },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = {
                query = "@local.scope",
                query_group = "locals",
                desc = "Select language scope",
            },
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true or false
        include_surrounding_whitespace = false,
    },
})

return { langs = langs }

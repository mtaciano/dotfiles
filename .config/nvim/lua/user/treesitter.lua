---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "doxygen",
        "cmake",
        "comment",
        "css",
        "fish",
        "git_config",
        "gitcommit",
        "gitignore",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "python",
        "rust",
        "toml",
        "typescript",
        "markdown",
        "tmux",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    textobjects = {
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
    },
})

-- Code completion
return {
    "saghen/blink.cmp",

    -- use a release tag to download pre-built binaries
    version = "1.*",
    dependencies = { "onsails/lspkind.nvim" },
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-e: Hide menu
        -- C-k: Toggle signature help
        --
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = {
            -- set to 'none' to disable the 'default' preset
            preset = "enter",

            ["<Tab>"] = {
                "select_next",
                "fallback",
            },
            ["<S-Tab>"] = {
                "select_prev",
                "fallback",
            },
            ["<C-n>"] = {
                "snippet_forward",
                "fallback",
            },
            ["<C-b>"] = {
                "snippet_backward",
                "fallback",
            },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },

        completion = {
            accept = { auto_brackets = { enabled = false } },
            list = { selection = { preselect = false, auto_insert = true } },
            menu = {
                draw = {
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if
                                    vim.tbl_contains(
                                        { "Path" },
                                        ctx.source_name
                                    )
                                then
                                    local dev_icon, _ =
                                        require("nvim-web-devicons").get_icon(
                                            ctx.label
                                        )
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon =
                                        require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
                                end

                                return icon .. ctx.icon_gap
                            end,

                            -- Optionally, use the highlight groups from nvim-web-devicons
                            -- You can also add the same function for `kind.highlight` if you want to
                            -- keep the highlight groups in sync with the icons.
                            highlight = function(ctx)
                                local hl = ctx.kind_hl
                                if
                                    vim.tbl_contains(
                                        { "Path" },
                                        ctx.source_name
                                    )
                                then
                                    local dev_icon, dev_hl =
                                        require("nvim-web-devicons").get_icon(
                                            ctx.label
                                        )
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end,
                        },
                    },
                },
            },
            -- Show documentation when selecting a completion item
            documentation = { auto_show = true, auto_show_delay_ms = 0 },

            -- Display a preview of the selected item on the current line
            ghost_text = { enabled = true, show_without_selection = true },
        },

        cmdline = {
            completion = { menu = { auto_show = true } },
        },

        -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },

        -- Experimental signature help support
        signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
}

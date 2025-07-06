local capabilities = require("blink.cmp").get_lsp_capabilities()
--local capabilities = require("user.lsp.completion")
local builtin = require("telescope.builtin")
-- local signature = require("lsp_signature")
local dap = require("dap")
local keymap = vim.keymap

local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue Debugging" })
    keymap.set(
        "n",
        "<Leader>db",
        dap.toggle_breakpoint,
        { desc = "Toggle Breakpoint" }
    )
    keymap.set(
        "n",
        "<Leader>dec",
        vim.lsp.buf.declaration,
        { desc = "Go to Declaration" }
    )
    keymap.set(
        "n",
        "<Leader>def",
        vim.lsp.buf.definition,
        { desc = "Go to Definition" }
    )
    keymap.set(
        "n",
        "<Leader>lig",
        vim.lsp.buf.implementation,
        { desc = "Go to Implementation" }
    )
    keymap.set(
        "n",
        "<C-h>",
        vim.lsp.buf.hover,
        { desc = "Show hover information" }
    )
    keymap.set(
        "n",
        "<Leader>ls",
        vim.lsp.buf.signature_help,
        { desc = "Show function signature" }
    )
    keymap.set("n", "<Leader>lh", function()
        vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr }),
            { bufnr }
        )
    end, { desc = "Toggle inlay hints" })
    -- keymap.set(
    --     "n",
    --     "<C-k>",
    --     signature.toggle_float_win,
    --     { desc = "Toggle function signature" }
    -- )
    keymap.set(
        "n",
        "<Leader>td",
        vim.lsp.buf.type_definition,
        { desc = "Show type definition" }
    )
    keymap.set(
        "n",
        "<Leader>lrn",
        vim.lsp.buf.rename,
        { desc = "Rename occurrences" }
    )
    keymap.set(
        "n",
        "<Leader>la",
        vim.lsp.buf.code_action,
        { desc = "Show code actions" }
    )
    keymap.set(
        "n",
        "<Leader>lrf",
        builtin.lsp_references,
        { desc = "Show References" }
    )
    keymap.set(
        "n",
        "<Leader>lci",
        builtin.lsp_incoming_calls,
        { desc = "Show incomming calls to this function" }
    )
    keymap.set(
        "n",
        "<Leader>lco",
        builtin.lsp_outgoing_calls,
        { desc = "Show outgoing calls to this function" }
    )
    keymap.set(
        "n",
        "<Leader>lds",
        builtin.lsp_document_symbols,
        { desc = "Show document symbols" }
    )
    keymap.set(
        "n",
        "<Leader>lws",
        builtin.lsp_workspace_symbols,
        { desc = "Show workspace symbols" }
    )
    keymap.set(
        "n",
        "<Leader>ldi",
        builtin.diagnostics,
        { desc = "Show diagnostics" }
    )
    keymap.set(
        "n",
        "<Leader>ldo",
        vim.diagnostic.open_float,
        { desc = "Show whole diagnostic" }
    )
    keymap.set(
        "n",
        "<Leader>lis",
        builtin.lsp_implementations,
        { desc = "Show implementations" }
    )
    keymap.set(
        "n",
        "<Leader>lde",
        builtin.lsp_definitions,
        { desc = "Show definitions" }
    )
    keymap.set(
        "n",
        "<Leader>lty",
        builtin.lsp_type_definitions,
        { desc = "Show type definitions" }
    )
end

-- Lua
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                version = "LuaJIT",
            },
            -- Do not send telemetry data
            telemetry = {
                enable = false,
            },
        },
    },
})

-- Rust
vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
            },
            check = {
                overrideCommand = {
                    "cargo",
                    "clippy",
                    "--workspace",
                    "--message-format=json",
                    "--all-targets",
                    "--all-features",
                },
            },
        },
    },
})

-- Typescript/JavaScript
vim.lsp.enable("eslint")
vim.lsp.config("eslint", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        experimental = { useFlatConfig = false },
    },
})
vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        preferences = { includeCompletionsForModuleExports = false },
    },
})

-- Prisma
vim.lsp.enable("prismals")
vim.lsp.config("prismals", {
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig").prismals.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Svelte
vim.lsp.enable("svelte")
vim.lsp.config("svelte", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Typst
vim.lsp.enable("tinymist")
vim.lsp.config("tinymist", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        formatterMode = "typstyle",
    },
})

-- CSS
vim.lsp.enable("cssls")
vim.lsp.config("cssls", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- JSON
vim.lsp.enable("jsonls")
vim.lsp.config("jsonls", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Docker
vim.lsp.enable("dockerls")
vim.lsp.config("dockerls", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("docker_compose_language_service")
vim.lsp.config("docker_compose_language_service", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- TailwindCSS
vim.lsp.enable("tailwindcss")
vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Python
vim.lsp.enable("ruff")
vim.lsp.config("ruff", {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        settings = {
            lint = {
                select = {
                    "E", -- pycodestyle
                    "W", -- pycodestyle
                    "F", -- Pyflakes
                    "UP", -- pyupgrade
                    "B", -- flake8-bugbear
                    "SIM", -- flake8-simplify
                    "I", -- isort
                    "C4", -- flake8-comprehensions
                },
            },
        },
    },
})
vim.lsp.enable("basedpyright")
vim.lsp.config("basedpyright", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        basedpyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
            analysis = {
                typeCheckingMode = "standard",
            },
        },
    },
})

-- C/C++
vim.lsp.enable("clangd")
vim.lsp.config("clangd", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("cmake")
vim.lsp.config("cmake", {
    capabilities = capabilities,
    on_attach = on_attach,
})

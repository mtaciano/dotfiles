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
vim.lsp.enable("lua_ls")

-- Rust
vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
            },
            check = {
                command = "clippy",
            },
        },
    },
})
vim.lsp.enable("rust_analyzer")

-- Typescript/JavaScript
vim.lsp.config("eslint", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        experimental = { useFlatConfig = false },
    },
})
vim.lsp.enable("eslint")
vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        preferences = { includeCompletionsForModuleExports = false },
    },
})
vim.lsp.enable("ts_ls")

-- Prisma
vim.lsp.config("prismals", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("prismals")

-- Svelte
vim.lsp.config("svelte", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("svelte")

-- Typst
vim.lsp.config("tinymist", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        formatterMode = "typstyle",
    },
})
vim.lsp.enable("tinymist")

-- CSS
vim.lsp.config("cssls", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("cssls")

-- JSON
vim.lsp.config("jsonls", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("jsonls")

-- Docker
vim.lsp.config("dockerls", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("dockerls")
vim.lsp.config("docker_compose_language_service", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("docker_compose_language_service")

-- TailwindCSS
vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("tailwindcss")

-- Python
vim.lsp.config("ruff", {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        settings = {
            configurationPreference = "filesystemFirst",
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
vim.lsp.enable("ruff")
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
vim.lsp.enable("basedpyright")

-- C/C++
vim.lsp.config("clangd", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("clangd")
vim.lsp.config("cmake", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("cmake")

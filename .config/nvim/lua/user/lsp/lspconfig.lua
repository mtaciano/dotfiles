local capabilities = require("user.lsp.completion")
local builtin = require("telescope.builtin")
local signature = require("lsp_signature")
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
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), bufnr)
    end, { desc = "Toggle inlay hints" })
    keymap.set(
        "n",
        "<C-k>",
        signature.toggle_float_win,
        { desc = "Toggle function signature" }
    )
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
require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize undefined globals
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data
            telemetry = {
                enable = false,
            },
        },
    },
})

-- Rust
require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                allFeatures = true,
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
require("lspconfig").eslint.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
-- Typescript
require("lspconfig").tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- TailwindCSS
require("lspconfig").tailwindcss.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Python
require("lspconfig").pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                pylint = { enabled = false },
            },
        },
    },
})
require("lspconfig").ruff_lsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- C/C++
require("lspconfig").clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig").cmake.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

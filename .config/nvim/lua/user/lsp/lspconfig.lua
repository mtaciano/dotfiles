local capabilities = require("user.lsp.completion")
local builtin = require("telescope.builtin")
local keymap = vim.keymap

local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    keymap.set(
        "n",
        "<Leader>ldc",
        vim.lsp.buf.declaration,
        { desc = "Go to Declaration" }
    )
    keymap.set(
        "n",
        "<Leader>ldf",
        vim.lsp.buf.definition,
        { desc = "Go to Definition" }
    )
    keymap.set(
        "n",
        "<Leader>li",
        vim.lsp.buf.implementation,
        { desc = "Go to Implementation" }
    )
    keymap.set(
        "n",
        "<Leader>ls",
        vim.lsp.buf.signature_help,
        { desc = "Show function signature" }
    )
    keymap.set(
        "n",
        "<Leader>ltd",
        vim.lsp.buf.type_definition,
        { desc = "Show type definition" }
    )
    keymap.set(
        "n",
        "<Leader>lr",
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
        "<Leader>flr",
        builtin.lsp_references,
        { desc = "Show References" }
    )
    keymap.set(
        "n",
        "<Leader>flci",
        builtin.lsp_incoming_calls,
        { desc = "Show incomming calls to this function" }
    )
    keymap.set(
        "n",
        "<Leader>flco",
        builtin.lsp_outgoing_calls,
        { desc = "Show outgoing calls to this function" }
    )
    keymap.set(
        "n",
        "<Leader>flsd",
        builtin.lsp_document_symbols,
        { desc = "Show document symbols" }
    )
    keymap.set(
        "n",
        "<Leader>flsw",
        builtin.lsp_workspace_symbols,
        { desc = "Show workspace symbols" }
    )
    keymap.set(
        "n",
        "<Leader>fld",
        builtin.diagnostics,
        { desc = "Show diagnostics" }
    )
    keymap.set(
        "n",
        "<Leader>fli",
        builtin.lsp_implementations,
        { desc = "Show implementations" }
    )
    keymap.set(
        "n",
        "<Leader>flf",
        builtin.lsp_definitions,
        { desc = "Show definitions" }
    )
    keymap.set(
        "n",
        "<Leader>fltd",
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

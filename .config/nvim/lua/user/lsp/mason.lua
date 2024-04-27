require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({
    handlers = {
        function(config)
            -- all sources with no handler get passed here
            -- Keep original functionality
            require("mason-nvim-dap").default_setup(config)
        end,
        codelldb = function(config)
            config.configurations = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    args = function()
                        local args_string = vim.fn.input("Arguments: ")
                        return vim.split(args_string, " ")
                    end,
                    program = function()
                        return vim.fn.input(
                            "Path to executable: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                },
            }
            require("mason-nvim-dap").default_setup(config)
        end,
    },
})

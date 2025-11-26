return {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        PATH = "append",
    },
    config = function(_, opts)
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup(opts)

        mason_lspconfig.setup({
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "dockerls",
                "lua_ls",
                "graphql",
                "docker_compose_language_service",
                "jsonls",
                "marksman",
                "powershell_es",
                "sqlls",
                "somesass_ls",
                "bashls",
                "gopls",
                "csharp_ls",
                "fsautocomplete",
                "nil_ls",
                -- "rust_analyzer",
                -- "ocamllsp",
            },
            automatic_installation = true,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "pylint",
                "eslint_d",
                "csharpier",
                "golines",
                "netcoredbg",
                "markdownlint",
                "editorconfig-checker",
                "shfmt",
                "ocamlformat",
                "nixfmt",
            },
            integrations = {
                ["mason-lspconfig"] = true,
                ["mason-null-ls"] = false,
                ["mason-nvim-dap"] = false,
            },
            run_on_start = true,
            start_delay = 0,
            debounce_hours = 24,
        })
    end,
}

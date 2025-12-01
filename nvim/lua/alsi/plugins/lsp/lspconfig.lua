return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} }, -- for Lua LS
	},
	config = function()
		local lspconfig = vim.lsp.config
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		local on_attach = require("alsi.core.lsp_keymaps").on_attach
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
			jump = { float = true },
			underline = { severity = vim.diagnostic.severity.INFO },
			update_in_insert = true,
		})
		vim.lsp.config("*", {
			capabilities = capabilities,
			on_attach = on_attach,
		})
		vim.lsp.config("ocamllsp", {
			filetypes = { "ocaml", "ocaml.interface", "reason", "reason.interface" },
			root_dir = require("lspconfig.util").root_pattern("dune-project", ".git"),
		})
		vim.lsp.config("docker_compose_language_service", {
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
					pattern = { "docker-compose*", "*compose*.yml", "*compose*.yaml" },
					command = "set filetype=yaml.docker-compose",
				})
				on_attach(client, bufnr)
			end,
		})
		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})
		vim.lsp.config("emmet_ls", {
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					workspace = { checkThirdParty = false },
				},
			},
		})
		vim.lsp.config("bashls", {
			filetypes = { "sh", "zsh" },
		})
		vim.lsp.config("fsautocomplete", {
			init_options = {
				FSharp = {
					fscOptions = {
						"--langversion:latest",
					},
				},
			},
		})
		vim.lsp.config("nil_ls", {
			settings = {
				["nil"] = {
					nix = { flake = { autoArchive = true } },
				},
			},
		})
		local csharpier = vim.api.nvim_create_augroup("csharpier", { clear = true })
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			group = csharpier,
			pattern = { "*.csproj", "*.fsproj" },
			callback = function()
				vim.bo.filetype = "xml"
			end,
		})
	end,
}

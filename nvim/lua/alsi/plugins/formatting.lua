return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				-- yaml = { "prettier" },
				markdown = { "markdownlint" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				cs = { "csharpier" },
				xml = { "csharpier" },
				-- fs = { "fantomas" },
				go = { "gofmt" },
				sh = { "shfmt" },
				sql = { "sleek" },
				nix = { "nixfmt" },
				-- pgfmt = { "pgfmt" },
				-- nginx = { "nginxfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 10000,
			},
			formatters = {
				nginxfmt = {
					command = "nginxfmt",
					args = { "--pipe" },
					stdin = true,
					stdout = true,
				},
				sleek = {
					command = "sleek",
					stdin = true,
					stdout = true,
				},
				csharpier = {
					command = "csharpier",
					args = { "format", "--write-stdout" },
					stdin = true,
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Override :W to save without formatting
		vim.api.nvim_create_user_command("W", function()
			vim.cmd("noautocmd w!")
		end, {})
	end,
}

local languages = {
	"json",
	"javascript",
	"typescript",
	"tsx",
	"yaml",
	"html",
	"css",
	"markdown",
	"markdown_inline",
	"graphql",
	"bash",
	"lua",
	"nix",
	"vim",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"c_sharp",
	"fsharp",
	"csv",
	"diff",
	"editorconfig",
	"git_config",
	"git_rebase",
	"gitcommit",
	"gitattributes",
	"php",
	"powershell",
	"python",
	"regex",
	"ocaml",
	"jinja2",
}

local function register_jinja_parser()
	require("nvim-treesitter.parsers").jinja2 = {
		install_info = {
			url = "https://github.com/dbt-labs/tree-sitter-jinja2",
			branch = "main",
		},
	}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = function()
			register_jinja_parser()
			require("nvim-treesitter").install(languages, { max_jobs = 4, summary = true }):wait(300000)
		end,
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = register_jinja_parser,
			})

			local treesitter = require("nvim-treesitter")

			treesitter.setup()

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			local ocaml = vim.api.nvim_create_augroup("ocaml", { clear = true })
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				group = ocaml,
				pattern = { "*.ml", "*.mli", "*.re", "*.rei" },
				callback = function()
					vim.bo.filetype = "ocaml"
				end,
			})

			local jinja = vim.api.nvim_create_augroup("jinja", { clear = true })
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				group = jinja,
				pattern = { "*.yaml.jinja" },
				callback = function()
					vim.bo.filetype = "jinja2"
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}

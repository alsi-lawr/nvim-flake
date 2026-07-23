return {
	dir = "/home/alex/dev/neotheme.nvim",
	priority = 1000,
	config = function()
		require("neotheme").setup({
			integrations = {
				bufferline = true,
				cmp = true,
				gitsigns = true,
				lazy = true,
				nvim_tree = true,
				telescope = true,
				trouble = true,
				which_key = true,
			},
		})
		vim.cmd("colorscheme neotheme")
	end,
}

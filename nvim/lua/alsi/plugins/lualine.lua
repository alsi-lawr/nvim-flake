return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")
		local palette = require("neotheme").palette()

		lualine.setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = palette.ui.accent },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
					{ "filename", path = 1 },
				},
			},
		})
	end,
}

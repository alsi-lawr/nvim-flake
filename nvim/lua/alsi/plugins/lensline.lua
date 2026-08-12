return {
	"oribarilan/lensline.nvim",
	event = "LspAttach",
	config = function()
		require("lensline").setup({
			profiles = {
				{
					name = "default",
					style = {
						placement = "inline",
						prefix = "  ",
					},
				},
			},
		})
	end,
}

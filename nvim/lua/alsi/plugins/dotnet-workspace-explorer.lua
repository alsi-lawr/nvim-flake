return {
	"alsi-lawr/dotnet-workspace-explorer.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{
			"<leader>dwe",
			"<cmd>DotnetWorkspaceExplorerToggle<CR>",
			desc = "Toggle .NET workspace explorer",
		},
		{
			"<leader>dwo",
			"<cmd>DotnetWorkspaceExplorerOpen<CR>",
			desc = "Open .NET workspace explorer",
		},
		{
			"<leader>dwc",
			"<cmd>DotnetWorkspaceExplorerClose<CR>",
			desc = "Close .NET workspace explorer",
		},
		{
			"<leader>dwf",
			"<cmd>DotnetWorkspaceExplorerFocus<CR>",
			desc = "Focus .NET workspace explorer",
		},
		{
			"<leader>dwr",
			"<cmd>DotnetWorkspaceExplorerRefresh<CR>",
			desc = "Refresh .NET workspace explorer",
		},
		{
			"<leader>dwa",
			"<cmd>DotnetWorkspaceExplorerNew<CR>",
			desc = "Create .NET workspace item",
		},
	},
	config = function()
		local command = vim.fn.exepath("dotnet-we")
		if command == "" then
			command = vim.fn.expand(
				"~/dev/dotnet-cli-plus/src/WorkspaceExplorer/bin/Release/net10.0/Dotnet.WorkspaceExplorer"
			)
		end

		require("dotnet-workspace-explorer").setup({
			width = 50,
			command = command,
			presentation = {
				devicons = true,
			},
		})
	end,
}

return {
	{
		dir = vim.fn.expand("~/dev/agent-term.nvim"),
		name = "agent-term.nvim",
		lazy = false,
		opts = {
			agents = {
				codex = {
					preset = "codex",
					auto_resume = "last",
				},
				claude = {
					preset = "claude",
					auto_resume = "last",
				},
				agy = {
					preset = "agy",
					auto_resume = "last",
				},
			},
			keymaps = {
				float_toggle = "<leader>ct",
				panel_toggle = "<leader>cp",
				close_all = "<leader>cX",
				kill = "<leader>ck",
				send_buffer_context = "<leader>cb",
				send_selection_context = "<leader>cs",
			},
		},
	},
}

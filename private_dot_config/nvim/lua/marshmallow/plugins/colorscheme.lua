return {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			term_colors = true,
		},
		config = function (opts)
			require("catppuccin").setup(opts)

			vim.cmd.colorscheme("catppuccin")
		end
}

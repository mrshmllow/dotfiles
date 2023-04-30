return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		term_colors = true,
		intergration = {
			neotree = true,
			gitsigns = true,
			treesitter_context = true,
			treesitter = true,
		},
		custom_highlights = function(colors)
			return {
				StatusLine = { bg = colors.base },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)

		vim.cmd.colorscheme("catppuccin")
	end,
}

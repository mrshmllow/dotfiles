local Util = require("marshmallow.util")

return {
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				spelling = {
					enabled = false,
				},
			})

			require("which-key").register({
				f = {
					name = "Find",
				},
				g = {
					name = "Git",
				},
				s = {
					name = "Search",
				},
			}, { prefix = "<leader>" })
		end,
	},
	{
		"Eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
	{
		"gbprod/stay-in-place.nvim",
		opts = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			space_char_blankline = " ",
			show_current_context = true,
			char = "▎",
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		branch = "v2.x",
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>fE",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
			{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		},
		opts = {
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = true,
			},
			window = {
				mappings = {
					["<space>"] = "none",
				},
			},
			default_component_configs = {
				name = {
					trailing_slash = true,
				},
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = vim.fn.executable("make") == 1,
			},
			"nvim-telescope/telescope-symbols.nvim",
		},
		keys = {
			{ "<leader><space>", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{ "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			-- find
			{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
			{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
			-- search
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>sl", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
			{ "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
			{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
			{
				"<leader>ss",
				Util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				Util.telescope("lsp_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
		},
		config = function()
			require("telescope").setup({})

			pcall(require("telescope").load_extension, "fzf")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			_signs_staged_enable = true,
			-- signs_staged_enable = true,
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		opts = true,
		keys = {
			{ "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo Comments" },
		},
	},
	{
		"m4xshen/autoclose.nvim",
		opts = {
			options = {
				disable_when_touch = true,
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = true,
	},
  {
    "voldikss/vim-floaterm",
    cmd = "FloatermNew",
    keys = {
      {"<leader>l", "<cmd>:FloatermNew --cwd=<root> --name=Lazygit --width=1.0 --height=1.0  lazygit<CR>", desc = "Open Lazygit"}
    }
  }
}

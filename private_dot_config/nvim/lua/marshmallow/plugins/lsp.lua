return {
	{
		"williamboman/mason.nvim",
		opts = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = true,
		dependencies = { "williamboman/mason.nvim" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "rust_analyzer", "tsserver", "lua_ls", "tailwindcss", "pyright" },
			})

			vim.diagnostic.config({
				virtual_text = false,
				signs = false,
				update_in_insert = true,
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "E", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set(
				"n",
				"<space>q",
				vim.diagnostic.setloclist,
				{ noremap = true, silent = true, desc = "Add diagnostics to list" }
			)

			local function default(bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set(
					"n",
					"<space>D",
					vim.lsp.buf.type_definition,
					{ noremap = true, silent = true, buffer = bufnr, desc = "Goto type definition" }
				)
				vim.keymap.set("n", "cd", vim.lsp.buf.rename, bufopts)
				vim.keymap.set(
					{ "n", "v" },
					"ga",
					vim.lsp.buf.code_action,
					{ noremap = true, silent = true, buffer = bufnr, desc = "Code Actions" }
				)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "<space>o", function()
					vim.lsp.buf.format({ async = true })
				end, { noremap = true, silent = true, buffer = bufnr, desc = "Format document" })
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name, bufnr)
					default(bufnr)
					require("lspconfig")[server_name].setup({})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								workspace = { checkThirdParty = false },
								telemetry = { enable = false },
								diagnostics = { globals = { "vim" } },
							},
						},
					})
				end,
				["tailwindcss"] = function()
					require("lspconfig").tailwindcss.setup({
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										{
											"cva\\(([^)]*)\\)",
											"[\"'`]([^\"'`]*).*?[\"'`]",
										},
									},
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"ThePrimeagen/refactoring.nvim",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			require("mason-null-ls").setup({
				automatic_installation = false,
			})

			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.code_actions.gitsigns,
				},
			})
		end,
	},
	{ "j-hui/fidget.nvim", dependencies = { "neovim/nvim-lspconfig" }, opts = true },
	{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", dependencies = { "neovim/nvim-lspconfig" }, opts = true },
}

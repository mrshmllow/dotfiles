return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "roobert/tailwindcss-colorizer-cmp.nvim",
        "onsails/lspkind.nvim"
    },
    config = function()
	    vim.g.completeopt = "menu,menuone,noselect"
	    local cmp = require("cmp")

	    cmp.setup({
	        snippet = {
	            expand = function(args)
		            require('luasnip').lsp_expand(args.body)
	            end,
	        },
	        window = {
	            -- documentation = cmp.config.window.bordered(),
	            completion = {
	                -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
	                col_offset = -3,
	                side_padding = 0,
	                scrolloff = 2
	            },
	        },
	        view = {
	            entries = { name = 'custom', selection_order = 'near_cursor' }
	        },
	        experimental = {
	            ghost_text = true
	        },
	        formatting = {
	            fields = { "kind", "abbr", "menu" },
	            format = function(entry, vim_item)
		            local kind = require("lspkind").cmp_format({ mode = "symbol", maxwidth = 50 })(entry,
		                    vim_item)
		            local strings = vim.split(kind.kind, "%s", { trimempty = true })
		            kind.kind = " " .. (strings[1] or "") .. " "
		            -- kind.menu = "    (" .. (strings[2] or "") .. ")"

		            return kind
	            end
	            -- format = require("lspkind").cmp_format({
	            --     mode = "symbol",
	            --     maxwidth = 50,
	            --     ellipsis_char = '...',
	            --     before = function(entry, vim_item)
	            --             return vim_item
	            --     end

	            -- })
	        },
	        mapping = cmp.mapping.preset.insert({
	            ['<C-b>'] = cmp.mapping.scroll_docs( -4),
	            ['<C-f>'] = cmp.mapping.scroll_docs(4),
	            ['<C-Space>'] = cmp.mapping.complete(),
	            ['<C-e>'] = cmp.mapping.abort(),
	            ['<CR>'] = cmp.mapping.confirm({ select = true }),
	        }),
	        sources = cmp.config.sources({
	            { name = 'nvim_lsp' },
	            { name = 'luasnip' }, -- For luasnip users.
	        }, {
	            { name = 'buffer' },
	        })
	    })

	    cmp.setup.cmdline({ '/', '?' }, {
	        mapping = cmp.mapping.preset.cmdline(),
	        sources = {
	            { name = 'buffer' }
	        }
	    })

	    cmp.setup.cmdline(':', {
	        mapping = cmp.mapping.preset.cmdline(),
	        sources = cmp.config.sources({
	            { name = 'path' }
	        }, {
	            { name = 'cmdline' }
	        })
	    })

	    require("tailwindcss-colorizer-cmp").setup({
	        color_square_width = 2,
	    })
    end
}

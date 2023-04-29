if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono Nerd Font Mono:h14"

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_hide_mouse_when_typing = true

	vim.g.neovide_cursor_animation_length = 0.13

	vim.g.winblend = 30
	vim.g.pumblend = 30

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)
end

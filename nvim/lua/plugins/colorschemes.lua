return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
    require('rose-pine').setup({
      highlight_groups = {
        ColorColumn = { bg = 'love' },
      }
    })
		vim.cmd("colorscheme rose-pine-dawn")
	end
}

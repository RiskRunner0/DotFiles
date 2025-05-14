return {
	"rose-pine/neovim",
	name = "rose-pine",
  priority = 1000,
	config = function()
    require('rose-pine').setup({
      highlight_groups = {
        ColorColumn = { bg = 'love' },
      }
    })
		vim.cmd("colorscheme rose-pine-dawn")
	end
}

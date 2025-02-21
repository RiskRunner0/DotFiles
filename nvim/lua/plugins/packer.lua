local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- You add plugins here
    -- Lazy Loading:
    -- Load on specific commands
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- Load on an autocommand event
    use {'andymass/vim-matchup', event = 'VimEnter'}

    -- Vim Airline
    use 'vim-airline/vim-airline'

    -- NerdTree
    use 'preservim/nerdtree'

    -- Auto Complete Commands
    use {
        'gelguy/wilder.nvim',
        config = function()
        end,
    }

    use 'preservim/tagbar'

    use 'ryanoasis/vim-devicons'

    -- docs: https://github.com/neoclide/coc.nvim
    use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- Telescope
    use {
	    'nvim-telescope/telescope.nvim', tag = '0.1.2',
	    -- or                            , branch = '0.1.x',
	    requires = { {'nvim-lua/plenary.nvim'} }
    }

  if packer_bootstrap then
    require('packer').sync()
  end
end)


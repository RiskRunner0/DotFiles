vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
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
        config = [[require('config.treesitter')]],
    }

end)


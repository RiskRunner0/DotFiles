return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    local keymap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = desc })
    end

    require("telescope").setup({})
    local builtin = require("telescope.builtin")

    keymap("<leader>sf", builtin.find_files, "Find files")
    keymap("<leader>sc", function()
      builtin.find_files {
        cwd = vim.fn.stdpath "config"
      }
    end, "Find config files")
    keymap("<leader><leader>", builtin.buffers, "Find buffers")
    keymap("<leader>s/", builtin.live_grep, "Live grep")
    keymap("<leader>/", function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
      )
    end, "Fuzzy find in buffer")

    vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
  end
}

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Add file to harpoon" })
    vim.keymap.set("n", "<leader>hd", function()
      harpoon:list():remove()
    end, { desc = "Remove file from harpoon" })
    vim.keymap.set("n", "<leader>hh", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })

    vim.keymap.set("n", "<leader>hq", function()
      harpoon:list():select(1)
    end, { desc = "Open harpoon file 1" })
    vim.keymap.set("n", "<leader>hw", function()
      harpoon:list():select(2)
    end, { desc = "Open harpoon file 2" })
    vim.keymap.set("n", "<leader>he", function()
      harpoon:list():select(3)
    end, { desc = "Open harpoon file 3" })
    vim.keymap.set("n", "<leader>hr", function()
      harpoon:list():select(4)
    end, { desc = "Open harpoon file 4" })

    vim.keymap.set("n", "<leader>hp", function()
      harpoon:list():prev()
    end, { desc = "Previous harpoon file" })
    vim.keymap.set("n", "<leader>hn", function()
      harpoon:list():next()
    end, { desc = "Next harpoon file" })
  end,
}

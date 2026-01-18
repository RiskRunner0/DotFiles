return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function ()
    local harpoon = require("harpoon")
    harpoon:setup()

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set(
      "n",
      "<C-h>a",
      function() harpoon:list():add() end,
      { desc = "Add file to harpoon",  }
    )
    vim.keymap.set(
      "n",
      "<C-h>d",
      function() harpoon:list():remove() end,
      { desc = "Remove file from harpoon" }
    )
    vim.keymap.set(
      "n",
      "<C-h>h",
      function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" }
    )

    vim.keymap.set("n", "<C-h>q", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-h>w", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-h>e", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-h>r", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-h>p>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-h>n>", function() harpoon:list():next() end)
  end
}

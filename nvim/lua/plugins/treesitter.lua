return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  config = function()
    local treesitter = require("nvim-treesitter")

    -- Setup with new API
    treesitter.setup()

    -- Install parsers
    treesitter.install({
      "bash",
      "embedded_template",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "ruby",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    })

    -- Enable syntax highlighting for all filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Enable treesitter-based indentation
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
}

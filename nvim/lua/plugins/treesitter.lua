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

    -- Enable syntax highlighting for filetypes with parsers
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        -- Try to start treesitter, silently fail if no parser exists
        pcall(vim.treesitter.start)
      end,
    })

    -- Enable treesitter-based indentation for filetypes with parsers
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        -- Only enable treesitter indentation if a parser exists
        if lang and pcall(vim.treesitter.language.add, lang) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    theme = vim.g.colors_name,
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        {
          'filename',
          path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
          file_status = true, -- Shows if file is read-only or modified
          symbols = {
            modified = ' ●', -- Text to show when the file is modified
            readonly = ' 🔒', -- Text to show when the file is read-only
            unnamed = '[No Name]', -- Text to show for unnamed buffers
          }
        }
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    }
  }
}

return {
  "stevearc/resession.nvim",
  lazy = false,
  opts = {},
  config = function(_, opts)
    local resession = require("resession")
    resession.setup(opts)

    vim.api.nvim_create_autocmd("VimLeavePre", {
      desc = "Save the session for the current directory",
      callback = function()
        local has_file_buffer = vim.iter(vim.api.nvim_list_bufs()):any(function(bufnr)
          return vim.bo[bufnr].buflisted and vim.bo[bufnr].buftype == "" and vim.api.nvim_buf_get_name(bufnr) ~= ""
        end)

        if has_file_buffer then
          resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
        end
      end,
    })
  end,
}

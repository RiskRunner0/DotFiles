return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    -- optional `vim.uv` typings for lazydev
    { "Bilal2453/luvit-meta", lazy = true },
    "hrsh7th/cmp-nvim-lsp",
    { 'j-hui/fidget.nvim',    opts = {} },
    "oxalica/nil",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    require('lspconfig').nil_ls.setup {}
    require('lspconfig').lua_ls.setup {}

    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    default_capabilities = vim.tbl_deep_extend(
      "force",
      default_capabilities,
      cmp_nvim_lsp.default_capabilities()
    )

    local server_configs = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              disable = {
                "missing-fields"
              }
            },
          },
        },
      },
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
      callback = function(e)
        local wk = require("which-key")
        local keymap = function(keys, desc, func)
          vim.keymap.set("n", keys, func, { buffer = e.buf })
          wk.add({ keys, desc = desc })
        end
        local builtin = require("telescope.builtin")

        keymap("gd", "Go to definitions", builtin.lsp_definitions)
        keymap("gD", "Declarations", vim.lsp.buf.declaration)
        keymap("gr", "References", builtin.lsp_references)
        keymap("gI", "Implementations", builtin.lsp_implementations)
        keymap("<leader>D", "Type definitions", builtin.lsp_type_definitions)
        keymap("<leader>ds", "Document symbols", builtin.lsp_document_symbols)
        keymap("<leader>ws", "Workspace symbols", builtin.lsp_dynamic_workspace_symbols)
        keymap("<leader>rn", "Rename", vim.lsp.buf.rename)
        keymap("<leader>ca", "Code actions", vim.lsp.buf.code_action)
        keymap("K", "Hover", vim.lsp.buf.hover)
      end
    })
  end
}

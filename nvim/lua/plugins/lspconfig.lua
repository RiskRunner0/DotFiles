return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    -- optional `vim.uv` typings for lazydev
    { "Bilal2453/luvit-meta", lazy = true },
    "mfussenegger/nvim-jdtls",
    "hrsh7th/cmp-nvim-lsp",
    { 'j-hui/fidget.nvim',    opts = {} },
    "oxalica/nil",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    require('lspconfig').ts_ls.setup {}
    lspconfig.nil_ls.setup({
      settings = {
        ['nil'] = {
          formatting = {
            command = { "nixpkgs-fmt" },
          },
        },
      },
    })
    require('lspconfig').rust_analyzer.setup {}
    require('lspconfig').sorbet.setup {}

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
      pylsp = {},
    }

    mason.setup()

    local mason_ensure_installed = vim.tbl_keys(server_configs or {})
    vim.list_extend(
      mason_ensure_installed,
      {
        -- place other packages you want to install but not configure with mason here
        -- e.g. language servers not configured with nvim-lspconfig, linters, formatters, etc.
        "stylua",
        "jdtls",
        "kotlin-language-server",
      }
    )
    mason_tool_installer.setup({
      ensure_installed = mason_ensure_installed
    })

    mason_lspconfig.setup({
      handlers = {
        function(server_name)
          local server_config = server_configs[server_name] or {}
          server_config.capabilities = vim.tbl_deep_extend(
            "force",
            default_capabilities,
            server_config.capabilities or {}
          )
          lspconfig[server_name].setup(server_config)
        end,
        ['jdtls'] = function() end,
      },
    })

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

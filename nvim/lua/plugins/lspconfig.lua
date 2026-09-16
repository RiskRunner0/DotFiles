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
    "hrsh7th/cmp-nvim-lsp",
    { 'j-hui/fidget.nvim',    opts = {} },
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local dd_gopls = vim.fn.exepath("dd-gopls")

    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    default_capabilities = vim.tbl_deep_extend(
      "force",
      default_capabilities,
      cmp_nvim_lsp.default_capabilities()
    )

    -- Consolidated LSP server configurations
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
      gopls = dd_gopls ~= "" and { cmd = { dd_gopls } } or {},
      rust_analyzer = {},
      sorbet = {},
    }

    mason.setup()

    local mason_servers = vim.tbl_keys(server_configs)
    if dd_gopls ~= "" then
      mason_servers = vim.tbl_filter(function(server_name)
        return server_name ~= "gopls"
      end, mason_servers)
    end
    table.sort(mason_servers)

    mason_tool_installer.setup({
      ensure_installed = { "stylua" },
    })

    for server_name, server_config in pairs(server_configs) do
      server_config.capabilities = vim.tbl_deep_extend(
        "force",
        default_capabilities,
        server_config.capabilities or {}
      )
      vim.lsp.config(server_name, server_config)
      vim.lsp.enable(server_name)
    end

    mason_lspconfig.setup({
      ensure_installed = mason_servers,
      automatic_enable = false,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
      callback = function(e)
        local keymap = function(keys, desc, func)
          vim.keymap.set("n", keys, func, { buffer = e.buf, desc = desc })
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

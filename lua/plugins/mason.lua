return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    cmd = {
      "MasonInstall",
      "MasonUninstall",
      "MasonList",
      "MasonUpdate",
      "MasonUpgrade",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = {
          -------------------------------------------------------------------
          -- lua stuff
          -------------------------------------------------------------------
          "lua_ls",
          -------------------------------------------------------------------
          -- Python
          -------------------------------------------------------------------
          "pyright", -- LSP Server
          -------------------------------------------------------------------
          -- web dev stuff
          -------------------------------------------------------------------
          "tsserver",
          "emmet_ls",
          "html",
          "cssls",
          "tailwindcss",
          "eslint",
          "prismals", --Next-generation ORM for Node.js & TypeScript
          "graphql", -- GraphQL: A query language for your API
          "svelte", -- Svelte language server: Web frontend compiler
          -------------------------------------------------------------------
          -- c/cpp stuff
          -------------------------------------------------------------------
          "clangd",
          -------------------------------------------------------------------
          -- Configurations & Documentation
          -------------------------------------------------------------------
          "taplo", -- TOML
          "yamlls", --
          "marksman", -- Markdown LS
          -------------------------------------------------------------------
          -- Misc.
          -------------------------------------------------------------------
          "jqls",
          "bashls", -- Bash LS
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "luacheck", -- lua linter
          "ruff", -- Python Linter
          "isort", -- python formatter
          "black", -- python formatter
          "pylint", -- python linter
          "eslint_d", -- js linter
          "clang-format",
        },
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    cmd = {
      "DapInstall",
      "DapUninstall",
    },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
        "js",
      })
    end,
  },
}

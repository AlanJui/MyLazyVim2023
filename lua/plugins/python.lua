return {
  -- {
  --   "nvim-neotest/neotest-python",
  -- },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    event = "VeryLazy",
    cmd = "VenvSelect",
    keys = {
      { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
    opts = function(_, opts)
      if require("lazyvim.util").has("nvim-dap-python") then
        opts.dap_enabled = true
      end
      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          python = ".venv/bin/python",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    keys = {
      {
        "<leader>dPt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Method",
        ft = "python",
      },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
        ft = "python",
      },
    },
    config = function()
      -- configure DAP Adapter
      local debugpy_path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(debugpy_path .. "/venv/bin/python")

      -- configure configurations of dap Adapter
      local dap = require("dap")
      local dap_configurations = {
        {
          type = "python",
          request = "launch",
          name = "My Launch file",
          program = "${file}",
        },
        {
          type = "python",
          request = "launch",
          name = "My Launch Django Server",
          cwd = "${workspaceFolder}",
          program = "${workspaceFolder}/manage.py",
          args = {
            "runserver",
            "--noreload",
          },
          django = true,
          console = "integratedTerminal",
          justMyCode = true,
        },
        {
          type = "python",
          request = "launch",
          name = "My Python: Django Debug Single Test",
          program = "${workspaceFolder}/manage.py",
          args = {
            "test",
            "${relativeFileDirname}",
          },
          django = true,
          console = "integratedTerminal",
        },
      }
      for _, config in ipairs(dap_configurations) do
        table.insert(dap.configurations.python, config)
      end
    end,
  },
}

return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>up",
        function()
          local Util = require("lazy.core.util")
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            Util.warn("Disabled auto pairs", { title = "Option" })
          else
            Util.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "echasnovski/mini.comment",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "echasnovski/mini.ai",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },
  -- A code outline window for skimming and quick navigation
  {
    "stevearc/aerial.nvim",
    keys = {
      --stylua: ignore
      { "<leader>o", "<CMD>AerialToggle<CR>", desc = "Toggle the Aerial Window", },
      { "<leader>to", "<CMD>AerialToggle<CR>", desc = "Toggle the Aerial Window" },
      { "}", "<CMD>AerialNext<CR>", desc = "Jump forwards 1 symbol" },
      { "{", "<CMD>AerialPrev<CR>", desc = "Jump backwards 1 symbol" },
    },
    config = true,
  },
  -- Splitting/Joining blocks of code
  {
    "Wansmer/treesj",
    dependices = { "nvim-treesitter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Toggle Split/Join Block" },
      { "<leader>tj", "<cmd>TSJToggle<cr>", desc = "Toggle Join Block" },
      { "<leader>ts", "<cmd>TSJToggle<cr>", desc = "Toggle Split Block" },
      { "<leader>cj", "<cmd>TSJJoin<cr>", desc = "Join Block" },
      { "<leader>cs", "<cmd>TSJSplit<cr>", desc = "Split Block" },
    },
    config = function()
      require("treesj").setup({})
      require("core.utils").load_mappings("treesj")
    end,
  },
}

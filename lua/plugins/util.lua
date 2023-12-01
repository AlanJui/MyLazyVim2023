return {
  {
    "dstein64/vim-startuptime",
    opts = {},
  },
  {
    "folke/persistence.nvim",
    opts = { options = vim.opt.sessionoptions:get() },
  },
  {
    "nvim-lua/plenary.nvim",
    opts = nil,
  },
  -------------------------------------------------------------------------------
  -- Tools
  -------------------------------------------------------------------------------
  -- File Manager
  {
    "vifm/vifm.vim",
    lazy = false,
    cmd = { "Vifm", "VifmOpen", "VifmTabOpen", "VifmSplitOpen", "VifmVsplitOpen" },
    keys = {
      {
        "<leader>uv",
        function()
          vim.cmd("Vifm")
        end,
        desc = "Open Vifm",
      },
    },
  },
  -- Todo matches on any text that starts with one of your defined keywords (or alt)
  -- followed by a colon:
  --
  --  TODO: do something
  --  FIX: this should be fixed
  --  HACK: weird code warning
  --
  --Todos are highlighted in all regular files.
  -------------------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xtt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xtT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>fx", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
    },
  },
}

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
}

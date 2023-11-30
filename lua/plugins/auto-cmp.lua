return {
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      history = true,
      delete_check_envents = "TextChanged",
    },
    config = function()
      -- load snippets paths
      -- this can be used if your configuration lives in ~/.config/nvim
      -- if your configuration lives in ~/.config/astronvim, the full path
      -- must be specified in the next line
      local config_dir = vim.fn.stdpath("config")
      local runtime_dir = vim.fn.stdpath("data")
      local package_root = runtime_dir .. "/lazy"

      require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
          -- "./lua/user/snippets",
          config_dir .. "/my-snippets",
          package_root .. "/friendly-snippets",
        },
      })

      -- extends filetypes supported by snippets
      require("luasnip").filetype_extend("javascript", { "javascriptreact" })
      require("luasnip").filetype_extend("vimwik", { "markdown" })
      require("luasnip").filetype_extend("markdown", { "css" })
      require("luasnip").filetype_extend("html", { "htmldjango" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "ray-x/cmp-treesitter",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local defaults = require("cmp.config.default")()

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "nvim_lua", priority = 800 },
          { name = "luasnip", priority = 750 },
          { name = "path", priority = 250 },
          { name = "calc", priority = 200 },
          { name = "emoji", priority = 100 },
          { name = "treesitter", priority = 90 },
          { name = "nvim_lsp_signature_help", priority = 10 },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    opts = {},
  },
}

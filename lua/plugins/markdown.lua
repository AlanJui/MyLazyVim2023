return {
  ----------------------------------------------------------------------------
  -- Markdown
  ----------------------------------------------------------------------------
  {
    -- PlantUML syntax highlighting
    {
      "aklt/plantuml-syntax",
      lazy = false,
      ft = { "plantuml" },
      keys = {
        { "<leader>up", "+PlantUML" },
        { "<leader>upu", "<cmd>PlantumlOpen<cr>", desc = "Open PlantUML Preview" },
        { "<leader>ups", "<cmd>PlantumlSave<cr>", desc = "Save PlantUML Preview" },
        { "<leader>upt", "<cmd>PlantumlToggle<cr>", desc = "Toggle PlantUML Preview" },
        { "<leader>tp", "<cmd>PlantumlToggle<cr>", desc = "Toggle PlantUML Preview" },
      },
    },
    -- provides support to mermaid syntax files (e.g. *.mmd, *.mermaid)
    {
      "mracos/mermaid.vim",
      lazy = false,
      ft = { "mermaid", "markdown" },
    },
    -- Markdown Syntax Highlighting
    -- URL: https://github.com/preservim/vim-markdown
    {
      "preservim/vim-markdown",
      config = function()
        -- 變更預設：文件內容毋需折疊
        vim.g.vim_markdown_folding_disabled = 1
        -- vim.g.markdown_fenced_languages = {
        --   "html",
        --   "python",
        --   "bash=sh",
        -- }
        -- disabling conceal for code fences
        -- vim.g.markdown_conceal_code_blocks = 0
      end,
    },
    -- Live server
    -- {
    --   "turbio/bracey.vim",
    --   build = "npm install --prefix server",
    -- },
    -- Open URI with your favorite browser from Neovim
    {
      "tyru/open-browser.vim",
      lazy = true,
      ft = { "plantuml", "markdown", "html" },
    },
    -- Preview markdown file
    {
      "iamcco/markdown-preview.nvim",
      lazy = false,
      enable = true,
      ft = { "markdown" },
      cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
      -- build = "cd app && yarn install",
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
      keys = {
        { "<leader>um", "+MarkDown" },
        { "<leader>umP", "<cmd> MarkdownPreview<CR>", desc = "Open Preview" },
        { "<leader>umc", "<cmd> MarkdownPreviewStop<CR>", desc = "Close Preview" },
        { "<leader>ump", "<cmd> MarkdownPreviewToggle<CR>", desc = "Toggle MarkdownPreview" },
        { "<leader>tm", "<cmd> MarkdownPreviewToggle<CR>", desc = "Toggle MarkdownPreview" },
      },
      init = function()
        -- 以下這選項，千萬不要設定，否則會造成無法正常預覽
        -- vim.g.mkdp_browserfunc = "open"
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_auto_start = true
        vim.g.mkdp_auto_close = true
        vim.g.mkdp_open_ip = "127.0.0.1"
        vim.g.mkdp_port = "9999"
        vim.g.mkdp_browser = ""
        vim.g.open_to_the_world = false
        vim.g.mkdp_echo_preview_url = true
        vim.g.mkdp_page_title = "${name}"
        vim.g.mkdp_preview_options = {
          mkit = {},
          katex = {},
          uml = {},
          maid = {},
          disable_sync_scroll = 0,
          sync_scroll_type = "middle",
          hide_yaml_meta = 1,
          sequence_diagrams = {},
          flowchart_diagrams = {},
          content_editable = false,
          disable_filename = 0,
          toc = {},
        }
        vim.g.mkdp_markdown_css = ""
        vim.g.mkdp_highlight_css = ""
      end,
      -- config = function()
      --   require("core.utils").load_mappings("markdown_preview")
      -- end,
    },
    -- PlantUML
    {
      "weirongxu/plantuml-previewer.vim",
      ft = { "plantuml" },
      dependices = {
        {
          -- Open URI with your favorite browser from Neovim
          "tyru/open-browser.vim",
          -- PlantUML syntax highlighting
          "aklt/plantuml-syntax",
          -- provides support to mermaid syntax files (e.g. *.mmd, *.mermaid)
          "mracos/mermaid.vim",
        },
      },
      cmd = { "PlantumlOpen", "PlantumlSave", "PlantumlToggle" },
      config = function()
        vim.g.my_jar_path = vim.fn.stdpath("data") .. "/lazy/plantuml-previewer.vim/lib/plantuml.jar"
        vim.cmd([[
          autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = g:my_jar_path
          let g:plantuml_previewer#save_format = "png"
          let g:plantuml_previewer#debug_mode = 1
        ]])
      end,
    },
  },
}

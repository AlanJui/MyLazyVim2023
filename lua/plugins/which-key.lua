return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ---------------------------------------------------------------------------
        -- Buffers
        ---------------------------------------------------------------------------
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>bx"] = { "<CMD>bdelete<CR>", "Close Buffer" },
        ["<leader>bX"] = { "<CMD>bdelete!<CR>", "Close Buffer with force" },
        ["<leader>bl"] = { "<CMD>ls<CR>", "List Buffers" },
        ---------------------------------------------------------------------------
        -- Coding
        ---------------------------------------------------------------------------
        ["<leader>c"] = { name = "+code" },
        -- LSP
        ["<leader>ca"] = {
          "<CMD> lua vim.lsp.buf.range_code_action()<CR>",
          "Do Range CodeAction",
        },
        ["<leader>cr"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename code" },
        ["<leader>cs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
        -- Diagnostics
        ["<leader>cdd"] = { "<cmd> lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show line diagnostics" },
        ["<leader>cdp"] = { "<cmd> lua vim.lsp.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
        ["<leader>cdn"] = { "<cmd> lua vim.lsp.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
        ["<leader>cdl"] = { "<cmd> lua vim.lsp.diagnostic.set_loclist()<CR>", "Set loclist" },
        -- Goto
        ["<leader>cgd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
        ["<leader>cgD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
        ["<leader>cgr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
        ["<leader>cgt"] = {
          "<cmd>lua vim.lsp.buf.type_definition()<CR>",
          "Go to type definition",
        },
        ["<leader>cgi"] = {
          "<cmd>lua vim.lsp.buf.implementation()<CR>",
          "Go to Implementation",
        },
        ---------------------------------------------------------------------------
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    }
    if require("lazyvim.util").has("noice.nvim") then
      opts.defaults["<leader>sn"] = { name = "+noice" }
    end
  end,
}

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vscode format i.e json files
vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/my_snippets"

local opt = vim.opt
local set = vim.opt -- global options
-- local cmd = vim.cmd -- execute Vim commands
-- local exec = vim.api.nvim_exec -- execute Vimscript

-- -----------------------------------------------
-- options
-- -----------------------------------------------
set.wrap = false -- don't automatically wrap on load
set.showmatch = true -- show the matching part of the pair for [] {} and ()
set.cursorline = true -- highlight current line

-- -----------------------------------------------
opt.colorcolumn = "80"
-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
-- Disable swap file
opt.swapfile = false
opt.backup = false
opt.writebackup = false
-- Folding
opt.foldcolumn = "1"
opt.foldlevel = 99 --- Using ufo provider need a large value
opt.foldlevelstart = 99 --- Expand all folds by default
opt.foldenable = true --- Use spaces instead of tabs
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- -----------------------------------------------
-- 啟用／關閉：顯示 Tab 控制字元
-- -----------------------------------------------
-- 初始狀態
vim.g.tab_char_state = 0

-- 切換控制字元設置的函數
function _G.toggle_tab_chars()
  if vim.g.tab_char_state == 0 then
    vim.g.tab_char_state = 1
    vim.opt.list = true
    vim.opt.listchars = "tab:»·,trail:╳"
  elseif vim.g.tab_char_state == 1 then
    vim.g.tab_char_state = 2
    vim.opt.listchars = "eol:↵,tab:»·,trail:╳,extends:»,precedes:«"
  else
    vim.g.tab_char_state = 0
    vim.opt.list = false
    vim.opt.listchars = ""
  end
end

-- 設置快捷鍵
vim.cmd([[
  set list
  command! ToggleTabDisplay lua _G.toggle_tab_chars()
]])
vim.api.nvim_set_keymap("n", "<leader>v", ":ToggleTabDisplay<CR>", { noremap = true, silent = true })

-------------------------------------------------
-- 針對 Markdown 文件的設置
-------------------------------------------------:
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.shiftwidth = 8
    vim.opt.tabstop = 8
    vim.opt.softtabstop = 8
  end,
})

-------------------------------------------------
local home_dir = os.getenv("HOME")
-------------------------------------------------
vim.g.loaded_python2_provider = 0
-- vim.g.loaded_python3_provider = 1
-- vim.g.python3_host_prog = home_dir .. "/.pyenv/versions/3.10.6/bin/python3.10"
-- vim.g.python3_host_prog = home_dir .. "/.pyenv/versions/3.10.6/envs/venv-3.10.6/bin/python3.10"
vim.g.python3_host_prog = home_dir .. "/.pyenv/versions/3.10.6/envs/venv-3.10.6/bin/python"

vim.g.node_host_prog = home_dir .. "/n/lib/node_modules/neovim/bin/cli.js"
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-------------------------------------------------
-- Config IndentBlanklineIndent
-------------------------------------------------
vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
vim.o.spell = true

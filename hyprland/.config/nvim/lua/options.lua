vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.colorcolumn = '120'

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true

vim.o.shell = '/bin/zsh'

vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.opt.sidescrolloff = 8
vim.o.confirm = true

vim.o.updatetime = 50
vim.o.termguicolors = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', {
    clear = true,
  }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  desc = '💡 Disable auto-commenting on new lines',
  group = vim.api.nvim_create_augroup('disable-auto-comment', { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

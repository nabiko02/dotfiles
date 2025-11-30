-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-C>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
  desc = 'Move focus to the left window',
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Move focus to the right window',
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Move focus to the lower window',
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Move focus to the upper window',
})

--
-- Mappings fzf
--
vim.keymap.set('n', '<leader><leader>', function()
  require('fzf-lua').files()
end, { desc = 'Search for files' })

vim.keymap.set('n', '<C-S-l>', function()
  require('fzf-lua').live_grep()
end, { desc = 'Search in files' })

vim.keymap.set('i', '<C-S-l>', function()
  require('fzf-lua').live_grep()
end, { desc = 'Search in files' })
---
--- Customs
---
vim.keymap.set('n', '<C-Backspace>', 'db') -- the good old ctrl backspace to get ride of a word
vim.keymap.set('i', '<C-Backspace>', '<Esc>dbxi') -- the good old ctrl backspace to get ride of a word

vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
vim.keymap.set('n', '<M-w>', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<cr>')

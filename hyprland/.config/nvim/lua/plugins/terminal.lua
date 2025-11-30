return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<M-a>]],
      shell = vim.o.shell,
      direction = 'horizontal',
    }
  end,
}

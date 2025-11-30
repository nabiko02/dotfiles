return {
  'navarasu/onedark.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme = 'onedark'
    vim.cmd.hi 'Comment gui=none'
  end,
  config = function()
    require('onedark').setup {
      style = 'darker',
    }

    require('onedark').load()
  end,
}

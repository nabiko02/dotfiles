return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup {
      n_lines = 500,
    }

    require('mini.surround').setup()
    require('mini.comment').setup {
      mappings = {
        comment_line = '<C-q>',
        comment_visual = '<C-q>',
      },
    }
  end,
}

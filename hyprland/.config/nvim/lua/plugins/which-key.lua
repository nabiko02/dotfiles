return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'modern',
    delay = 0,
    spec = {
      {
        '<leader>t',
        group = '[T]oggle',
      },
      {
        '<leader>h',
        group = 'Git [H]unk',
        mode = { 'n', 'v' },
      },
    },
  },
}

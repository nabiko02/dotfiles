return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  config = function()
    require('onedarkpro.config').set_theme 'onedark_dark'
    require('onedarkpro').setup {
      -- For more details : https://github.com/olimorris/onedarkpro.nvim/blob/main/lua/onedarkpro/highlights/editor.lua
      highlights = {
        CursorLineNr = { fg = '#ff9e64', bg = '#2C313C', bold = true },
        CursorLine = { bg = '#2C313C' },
        Search = { bg = '#ADD8E6', fg = '#0000FF' },
        IncSearch = { bg = '#ADD8E6', fg = '#0000FF' },
        Visual = { bg = '#2C313C' },
      },
      style = {
        functions = 'italic',
        methods = 'italic',
        keywords = 'bold,italic',
        types = 'bold',
      },
    }
    require('onedarkpro').load()
  end,
}

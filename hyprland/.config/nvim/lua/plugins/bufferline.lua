return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup()
  end,

  opts = {
    options = {
      mode = 'tabs',
      themable = true,
      numbers = 'none',
      buffer_close_icon = '',
      close_icon = '',
      section_separators = '',
      component_separators = '',
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
          s = s .. n .. sym
        end
        return s
      end,
    },
  },
}

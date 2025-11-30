return {
  'NMAC427/guess-indent.nvim', -- detect tabstop and shiftwidth automatically
  config = function()
    require('guess-indent').setup {}
  end,
}

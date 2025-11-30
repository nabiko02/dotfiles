return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      'angular',
      'bash',
      'c',
      'dockerfile',
      'diff',
      'git_config',
      'gitignore',
      'go',
      'html',
      'java',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'kotlin',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'rust',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = {
      enable = true,
      disable = { 'ruby' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      mode = 'cursor',
      max_lines = 3,
    },
  },
}

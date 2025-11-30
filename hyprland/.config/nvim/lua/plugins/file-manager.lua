return {
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/snacks.nvim',
    },
    config = function()
      require('fzf-lua').setup {}
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = true,
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { '\\', '<Cmd>Neotree toggle reveal position=float<CR>', desc = 'Toggle Neotree' },
    },
    ---@module "neo-tree"
    ---@type neotree.Config?
    config = function()
      require('neo-tree').setup {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_hidden = false,
            hide_gitignored = false,
          },
        },
        window = {
          width = 40,
          mappings = {
            ['L'] = 'focus_preview',
            ['l'] = 'toggle_node',
            ['h'] = 'toggle_node',
            ['<C-C>'] = 'cancel',
            ['P'] = {
              'toggle_preview',
              config = {
                use_float = true,
                use_snacks_image = true,
              },
            },
          },
        },
      }
    end,
  },
  {
    'mikavilpas/yazi.nvim',
    enabled = false,
    event = 'VeryLazy',
    dependencies = {
      'folke/snacks.nvim',
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}

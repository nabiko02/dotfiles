return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
        }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
    {
      '<C-S-f>',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
        }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = {
        c = true,
        cpp = true,
      }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      bash = { 'shfmt' },
      lua = { 'stylua' },
      markdown = { 'markdownlint' },
      json = { 'biome' },
      jsonc = { 'biome' },
      javascript = { 'biome' },
      javascriptreact = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      css = { 'biome' },
      scss = { 'biome' },
      sass = { 'biome' },
      terraform = { 'terraform_fmt' },
      python = { 'black' },
      toml = { 'toplo' },
      yaml = { 'yamlfmt' },
    },
  },
}

-- vim : ts=2 sts=2 sw=2 et

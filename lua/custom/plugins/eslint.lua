return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      vue = { 'eslint_d' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }

    -- Configure eslint_d for better performance
    lint.linters.eslint_d.args = {
      '--no-warn-ignored',
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only lint if the buffer is attached to a file
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname ~= '' and vim.bo.buftype == '' then
          lint.try_lint()
        end
      end,
    })

    -- Optional: Add a keymap to manually trigger linting
    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}

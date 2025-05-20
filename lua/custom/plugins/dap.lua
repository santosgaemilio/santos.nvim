return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      -- Setup UI
      dapui.setup()
      -- Setup adapter for codelldb
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          -- CHANGE THIS PATH to your actual codelldb location
          command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }
      -- Configure C++ debugging
      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }
      -- Clone the configuration for C
      dap.configurations.c = dap.configurations.cpp
      -- Keymaps
      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end, { desc = 'Debug: Continue' })
      vim.keymap.set('n', '<F10>', function()
        dap.step_over()
      end, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', function()
        dap.step_into()
      end, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F12>', function()
        dap.step_out()
      end, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>db', function()
        dap.toggle_breakpoint()
      end, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Conditional Breakpoint' })
      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.open()
      end, { desc = 'Debug: Open REPL' })
      vim.keymap.set('n', '<leader>dl', function()
        dap.run_last()
      end, { desc = 'Debug: Run Last' })
      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}

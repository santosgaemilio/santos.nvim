return {
  {
    'Civitasv/cmake-tools.nvim',
    config = function()
      require('cmake-tools').setup {
        cmake_command = 'cmake',
        cmake_build_directory = 'build',
        cmake_generate_options = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
        cmake_build_options = {},
        cmake_console_size = 10,
        cmake_show_console = 'always',
        cmake_dap_configuration = {
          name = 'cpp',
          type = 'codelldb',
          request = 'launch',
          stopOnEntry = false,
          runInTerminal = true,
          console = 'integratedTerminal',
        },
        cmake_variants_message = {
          short = { show = true },
          long = { show = true, max_length = 40 },
        },
      }

      -- Keymaps
      vim.keymap.set('n', '<leader>cg', '<cmd>CMakeGenerate<CR>', { desc = 'CMake: Generate' })
      vim.keymap.set('n', '<leader>cb', '<cmd>CMakeBuild<CR>', { desc = 'CMake: Build' })
      vim.keymap.set('n', '<leader>cc', '<cmd>CMakeClean<CR>', { desc = 'CMake: Clean' })
      vim.keymap.set('n', '<leader>cd', '<cmd>CMakeDebug<CR>', { desc = 'CMake: Debug' })
      vim.keymap.set('n', '<leader>cr', '<cmd>CMakeRun<CR>', { desc = 'CMake: Run' })
      vim.keymap.set('n', '<leader>cs', '<cmd>CMakeSettings<CR>', { desc = 'CMake: Settings' })
    end,
  },
}

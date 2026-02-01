return {
  -- LSP Configuration with Vue support
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      local lspconfig = require 'lspconfig'

      -- Vue Language Server path (Mason installation)
      local vue_language_server_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

      -- Vue TypeScript plugin configuration
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }

      -- VTSLS configuration (replaces tsserver)
      local vtsls_config = {
        init_options = {
          plugins = {
            vue_plugin,
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      }

      -- Vue Language Server configuration
      local vue_ls_config = {
        on_init = function(client)
          client.handlers['tsserver/request'] = function(_, result, context)
            local clients = vim.lsp.get_clients { bufnr = context.bufnr, name = 'vtsls' }
            if #clients == 0 then
              vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work with it.', vim.log.levels.ERROR)
              return
            end
            local ts_client = clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
              command = 'typescript.tsserverRequest',
              arguments = {
                command,
                payload,
              },
            }, { bufnr = context.bufnr }, function(_, r)
              local response_data = { { id, r.body } }
              client:notify('tsserver/response', response_data)
            end)
          end
        end,
      }

      -- Setup the language servers
      lspconfig.vtsls.setup(vtsls_config)
      lspconfig.vue_ls.setup(vue_ls_config)
    end,
  },

  -- Auto-close and rename HTML tags
  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'tsx', 'jsx' },
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      }
    end,
  },

  -- Color highlighting for CSS
  {
    'norcalli/nvim-colorizer.lua',
    ft = { 'css', 'scss', 'html', 'vue' },
    config = function()
      require('colorizer').setup({
        'css',
        'scss',
        'html',
        'vue',
      }, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        css = true,
        css_fn = true,
      })
    end,
  },

  -- Formatting with Prettier
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        vue = { 'prettier' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        markdown = { 'prettier' },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
}

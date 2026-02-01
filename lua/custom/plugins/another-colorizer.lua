return {
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
}

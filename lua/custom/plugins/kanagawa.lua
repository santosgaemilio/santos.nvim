return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {
              ui = {
                bg_gutter = '#181616',
              },
            },
            all = {},
          },
        },
        overrides = function(colors)
          return {
            BlinkCmpMenu = { bg = colors.palette.dragonBlack3 },
            BlinkCmpLabelDetail = { bg = colors.palette.dragonBlack3 },
            BlinkCmpMenuSelection = { bg = colors.palette.waveBlue1 },
          }
        end,
        theme = 'dragon', -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = 'dragon', -- try "dragon" !
          light = 'dragon',
        },
      }
      vim.cmd.colorscheme 'kanagawa-dragon'
    end,
  },
}

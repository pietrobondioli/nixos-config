return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        float = {
          transparent = true,
          solid = false,
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          harpoon = true,
          illuminate = true,
          indent_blankline = {
            enabled = false,
            scope_color = "sapphire",
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = { enabled = true },
          notify = true,
          nvimtree = true,
          neotree = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
        },
      })

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },

  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = true,
    opts = {
      style = "storm",
      transparent = true,
      transparent_background = true,
    },
  },

  {
    "sainnhe/everforest",
    name = "everforest",
    lazy = true,
    config = function()
      vim.g.everforest_transparent_background = 1
    end,
  },

  { "NLKNguyen/papercolor-theme", name = "papercolor", lazy = true },

  {
    "morhetz/gruvbox",
    name = "gruvbox",
    lazy = true,
    config = function()
      vim.g.gruvbox_transparent_background = 1
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      styles = {
        transparency = true,
      },
    },
  },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = true,
    opts = {
      transparent = true,
    },
  },

  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = true,
    opts = {
      transparent = true,
    },
  },
}

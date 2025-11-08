return {
  { "akinsho/bufferline.nvim", enabled = false, event = "VeryLazy", keys = false },
  {
  "nvim-treesitter/nvim-treesitter",
  build = false,
  opts = {
    auto_install = false,  -- Disable automatic installation
    ensure_installed = {}, -- Don't auto-install any parsers
  },
}
}

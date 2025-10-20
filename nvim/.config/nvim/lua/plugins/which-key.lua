return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    position = "bottom",
    layout = {
      align = "right",
    },
    width = 0.6,
    height = 0.6,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
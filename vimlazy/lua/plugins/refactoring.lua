return {
  "ThePrimeagen/refactoring.nvim",
  enabled = false,
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup()
  end,
}

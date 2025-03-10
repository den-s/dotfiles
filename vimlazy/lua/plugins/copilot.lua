return {
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
}

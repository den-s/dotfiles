return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  default_mappings = true,
  keys = {
    {
      "gpd",
      function()
        require("goto-preview").goto_preview_definition()
      end,
      desc = "Goto Preview Definition",
    },
    {
      "gpD",
      function()
        require("goto-preview").goto_preview_declaration()
      end,
      desc = "Goto Preview declaration",
    },
    {
      "gpi",
      function()
        require("goto-preview").goto_preview_implementation()
      end,
      desc = "Goto Preview Implementation",
    },
    {
      "gpt",
      function()
        require("goto-preview").goto_preview_type_definition()
      end,
      desc = "Goto Preview Type Definition",
    },
    {
      "gpr",
      function()
        require("goto-preview").goto_preview_references()
      end,
      desc = "Goto Preview Regerences",
    },
    {
      "gP",
      function()
        require("goto-preview").close_all_win()
      end,
      desc = "Close all Goto Preview windows",
    },
  },
}

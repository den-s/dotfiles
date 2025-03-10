-- return {
--   "ggandor/leap.nvim",
--   enabled = true,
--   keys = {
--     { "f", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
--     { "F", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
--     -- { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
--   },
--   config = function(_, opts)
--     local leap = require("leap")
--     for k, v in pairs(opts) do
--       leap.opts[k] = v
--     end
--     leap.add_default_mappings(true)
--     vim.keymap.del({ "x", "o" }, "x")
--     vim.keymap.del({ "x", "o" }, "X")
--   end,
-- }

return {
    "ggandor/leap.nvim",
    enabled=false,
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      -- vim.keymap.set({'n', 'x'}, 's', '<Plug>(leap)')
      -- vim.keymap.set({'n', 'x'}, 'S', '<Plug>(leap-from-window)')
      -- vim.keymap.set('o',        's', '<Plug>(leap-forward)')
      -- vim.keymap.set('o',        'S', '<Plug>(leap-backward)')
    vim.keymap.set('n', 's', '<Plug>(leap-anywhere)')
    vim.keymap.set('x', 's', '<Plug>(leap)')
    vim.keymap.set('o', 's', '<Plug>(leap-forward)')
    vim.keymap.set('o', 'S', '<Plug>(leap-backward)')
      -- vim.keymap.del({ "x", "o" }, "x")
      -- vim.keymap.del({ "x", "o" }, "X")
      -- vim.keymap.set("n", "f", function()
      --   require("leap").leap { target_windows = { vim.api.nvim_get_current_win() } }
      -- end)
      -- vim.keymap.set("n", "F", function()
      --   require("leap").leap {backward = true, target_windows = { vim.api.nvim_get_current_win() } }
      -- end)
    end,
  }

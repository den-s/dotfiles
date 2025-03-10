return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = true,
  opts = function()
    local Rule = require("nvim-autopairs.rule")
    local npairs = require("nvim-autopairs")
    local cond = require 'nvim-autopairs.conds'
    npairs.setup {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<C-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
      enable_check_bracket_line = false,
      ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
    }
    local function rule2(a1,ins,a2,lang)
      npairs.add_rule(
        Rule(ins, ins, lang)
          :with_pair(function(opts) return a1..a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          return a1..ins..ins..a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
        end)
      )
    end

    rule2('{%', '%}', 'htmldjango')
    npairs.add_rules = {
      Rule(' ', ' ')
        :with_pair(function (opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
      Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
        end)
        :use_key(')'),
      Rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
      Rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']'),
      Rule('{', '}')
        :end_wise(function() return true end),
    }
  end,
}

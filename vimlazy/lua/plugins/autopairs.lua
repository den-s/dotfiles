return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  -- config = true,
  config = function()
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
      -- disable_filetype = { "TelescopePrompt", "spectre_panel" },
      -- fast_wrap = {
      --   map = "<C-e>",
      --   chars = { "{", "[", "(", '"', "'" },
      --   pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      --   offset = 0, -- Offset from pattern match
      --   end_key = "$",
      --   keys = "qwertyuiopzxcvbnmasdfghjkl",
      --   check_comma = true,
      --   highlight = "PmenuSel",
      --   highlight_grey = "LineNr",
      -- },
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

    rule2('{', '%', '}', 'htmldjango')
    rule2('{%', ' ', '%}', 'htmldjango')
    -- rule2('{', ' ', '}', 'htmldjango')

    rule2('{', '%', '}', 'html')
    rule2('{%', ' ', '%}', 'html')

    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
    npairs.add_rules {
      -- Rule for a pair with left-side ' ' and right side ' '
      Rule(' ', ' ')
        -- Pair will only occur if the conditional function returns true
        :with_pair(function(opts)
          -- We are checking if we are inserting a space in (), [], or {}
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2]
          }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        -- We only want to delete the pair of spaces when the cursor is as such: ( | )
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({
            brackets[1][1] .. '  ' .. brackets[1][2],
            brackets[2][1] .. '  ' .. brackets[2][2],
            brackets[3][1] .. '  ' .. brackets[3][2]
          }, context)
        end)
    }
    -- For each pair of brackets we will add another rule
    for _, bracket in pairs(brackets) do
      npairs.add_rules {
        -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
        Rule(bracket[1] .. ' ', ' ' .. bracket[2])
          :with_pair(cond.none())
          :with_move(function(opts) return opts.char == bracket[2] end)
          :with_del(cond.none())
          :use_key(bracket[2])
          -- Removes the trailing whitespace that can occur without this
          :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
      }
    end

    -- npairs.add_rules = {
    --   Rule(' ', ' ')
    --     :with_pair(function (opts)
    --       local pair = opts.line:sub(opts.col - 1, opts.col)
    --       return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    --     end),
    --   Rule('( ', ' )')
    --     :with_pair(function() return false end)
    --     :with_move(function(opts)
    --       return opts.prev_char:match('.%)') ~= nil
    --     end)
    --     :use_key(')'),
    --   Rule('{ ', ' }')
    --     :with_pair(function() return false end)
    --     :with_move(function(opts)
    --       return opts.prev_char:match('.%}') ~= nil
    --     end)
    --     :use_key('}'),
    --   Rule('[ ', ' ]')
    --     :with_pair(function() return false end)
    --     :with_move(function(opts)
    --       return opts.prev_char:match('.%]') ~= nil
    --     end)
    --     :use_key(']'),
    --   Rule('{', '}')
    --     :end_wise(function() return true end),
    -- }
  end,
}

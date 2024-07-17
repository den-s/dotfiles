local ls = require("luasnip")
local extras = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt

local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local rep = extras.rep

return {
  s("im", fmt([[
    from {} import {}
    ]], {
      i(1),
      i(2),
    })),
  s("cl", fmt([[
    class {}:
        def __init__(self{}):
            {}
    ]], {
      i(1),
      i(2),
      i(3, "pass"),
    })),
  s("def", fmt([[
    def {}({}):
        {}
    ]], {
      i(1),
      c(2, {fmt([[self, {}]], i(1)), i(1)}),
      i(3, "pass"),
    })),
  s("p", fmt([[
    print(f"{}: {{{}}}")
    ]], {
      rep(1),
      i(1),
    })),
}, {
    s("autotrig", t("autotriggered, if enabled")),
  }

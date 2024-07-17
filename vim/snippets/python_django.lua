local ls = require("luasnip")
local extras = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt

local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local rep = extras.rep

return {
  s("clv", fmt([[
    class {}:
        def {}(self, request{}):
            {}
    ]], {
      i(1),
      c(2, {t("get"), t("post"), t("put"), t("delite")}),
      i(3),
      i(4, "pass"),
    })),
  s("cls", fmt([[
    class {}{}:
        class Meta:
            model = {}
            fields = [{}]
    ]], {
      i(1),
      c(2, {fmt([[({})]], i(1, "ModelSerializer")), t("")}),
      i(3),
      i(4),
    })),
  s("im", fmt([[
    from {} import {}
    ]], {
      i(1),
      i(2),
    })),
}

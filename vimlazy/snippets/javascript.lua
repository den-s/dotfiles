local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node
local s = ls.snippet

local extras = require("luasnip.extras")
local rep = extras.rep
local f = ls.function_node
local c = ls.choice_node

local fmt = require("luasnip.extras.fmt").fmt

local function realtime(args, snip)
  return args[1][1]:gsub("'", "\"")
end

return {
  s("c", fmt([[
    const {{ {const} }} = {var}{semi}
    ]], {
      const = i(1),
      var = i(2),
      semi = i(3, ";"),
      })),
  s("ed", fmt([[
    export default {}{}
    ]], {
      i(1),
      i(2, ";"),
      })),
  s("clr", fmt([[
    console.tron.display(====> {{value: {}, name: '{}'}}){}
    ]], {
      i(1),
      f(realtime, 1),
      c(2, {t(";"), t("")}),
      })),
  s("cl", fmt([[
    console.log('{} ====> ', {}){}
    ]], {
      i(1),
      rep(1),
      c(2, {t(";"), t("")}),
      })),
  s("cld", fmt([[
    console.log('{} ====> ', {}){}
    ]], {
      f(realtime, 1),
      i(1),
      c(2, {t(";"), t("")}),
      })),
  s("clj", fmt([[
    console.log('{} ====> ', JSON.stringify({}, null, 2)){}
    ]], {
      i(1),
      rep(1),
      c(2, {t(";"), t("")}),
      })),
  s("clb", fmt([[
    console.log('{} ====> ', {} ? 'true' : 'false'){}
    ]], {
      i(1),
      rep(1),
      c(2, {t(";"), t("")}),
      })),
  s("cw", fmt([[
    console.warn('{} ====> ', {}){}
    ]], {
      i(1),
      rep(1),
      c(2, {t(";"), t("")}),
      })),
  s("ci", fmt([[
    console.info('{} ====> ', {}){}
    ]], {
      i(1),
      rep(1),
      c(2, {t(";"), t("")}),
      })),
  s("cg", fmt([[
    console.group({}){}
    {}
    console.groupEnd(){}
    ]], {
      i(1),
      c(2, {t(";"), t("")}),
      i(3),
      rep(2),
      })),
  s("timeout", fmt([[
    setTimeout(() => {{
      {}
    }}, {}){}
    ]], {
      i(2),
      i(1),
      c(3, {t(";"), t("")}),
      })),
  s("im", fmt([[
    import {{ {} }} from '{}'{}
    ]], {
      i(1),
      i(2),
      c(3, {t(";"), t("")}),
      })),
  s("imd", fmt([[
    import {} from '{}'{}
    ]], {
      i(1),
      i(2),
      c(3, {t(";"), t("")}),
      })),
  s("imR", t("import R from 'ramda';")),
  s("imM", t("import moment from 'moment';")),
  s("imS", fmt([[
    import {}tyles from '{}'{}
    ]], {
      c(1, {t("s"), t("S")}),
      i(2, './styles'),
      c(3, {t(";"), t("")}),
      })),
  s("try", fmt([[
    try {{
      {}
    }} catch ({}) {{
      console.log('Error ====> ', {}){}
    }}
    ]], {
      i(1),
      i(2, 'e'),
      rep(2),
      c(3, {t(";"), t("")}),
    })),
  s("ctor", fmt([[
    constructor() {{
      {}
    }}
    ]], {
      c(1, {fmt([[super(){}]], i(1)), i(1)})
    })),
  s("for", fmt([[
    for(let {name} = 0; {name2} < {array}.length; {name3}++) {{
      {cur}
    }}
    ]], {
      name = i(1, 'i'),
      name2 = rep(1),
      name3 = rep(1),
      array = i(2),
      cur = i(3),
    })),

    }, {}

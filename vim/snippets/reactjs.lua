local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node
local s = ls.snippet

local f = ls.function_node
local c = ls.choice_node

local fmt = require("luasnip.extras.fmt").fmt

local function uppercase_first_param(args, snip)
  return (args[1][1]:gsub("^%l", string.upper))
end

return {
  s("useS", fmt([[
  const [{}, set{}] = useState<{}>({}){}
    ]], {
      i(1),
      f(uppercase_first_param, 1),
      i(2, 'boolean'),
      i(3),
      c(4, {t(";"), t("")}),
    })),
  s("useE", fmt([[
    useEffect(() => {{
      {}
    }}, [{}]){}
    ]], {
      i(1),
      i(2),
      c(3, {t(";"), t("")}),
    })),
  s("useR", fmt([[
    const {} = useRef<{}>({}){}
    ]], {
      i(1),
      i(2, 'boolean'),
      i(3),
      c(4, {t(";"), t("")}),
    })),
  s("ir", fmt([[import {} from 'react';]], {i(1, "React")})),
}, {
    s("autotrig", t("autotriggered, if enabled")),
  }

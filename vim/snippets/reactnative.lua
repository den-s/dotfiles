local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node
local s = ls.snippet

local c = ls.choice_node

local fmt = require("luasnip.extras.fmt").fmt

return {
  s("iRN", fmt([[
    import {{ {} }}  from 'react-native'{}
    ]], {
      i(1),
      c(2, {t(";"), t("")}),
    })),
  s("iSS", fmt([[
    import {{ StyleSheet }} from 'react-native';

    export default StyleSheet.create({{{}}});
    ]], {
      i(1),
    })),
}, {
    s("autotrig", t("autotriggered, if enabled")),
  }


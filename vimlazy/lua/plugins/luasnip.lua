return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	-- version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
  -- event = "InsertEnter",

  config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    require("luasnip.loaders.from_lua").lazy_load({paths = "./snippets"})

    ls.config.set_config({
      history = false,
      enable_autosnippets = true,
      updateevents = "TextChanged,TextChangedI",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "⇆", "ErrorMsg" } },
            --virt_text = { { "●", "GruvboxOrange" } },
          },
        },
      },
    })

    ls.filetype_extend("typescriptreact", {"reactjs", "javascript", "reactnative"})
    ls.filetype_extend("javascriptreact", {"reactjs", "javascript", "reactnative"})
    ls.filetype_extend("typescript", {"javascript", "reactnative"})
    ls.filetype_extend("javascript", {"javascript"})
    ls.filetype_extend("htmldjango", {"javascript"})
    ls.filetype_extend("python", {"python", "python_django"})

    local opts = { silent = true }

    vim.keymap.set({ "i", "s" }, "<c-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump(1)
      end
    end, opts)

    vim.keymap.set({ "i", "s" }, "<c-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, opts)

    vim.keymap.set({ "i", "s" }, "<c-c>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    vim.keymap.set({ "i", "t" }, "<c-t>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end)

    function Leave_snippet()
      if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
      then
        require('luasnip').unlink_current()
      end
    end

    -- stop snippets when you leave to normal mode
    vim.api.nvim_command([[
        autocmd ModeChanged * lua Leave_snippet()
    ]])
  end
}

-- Setup nvim-cmp.
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}


cmp.setup({
  view = {
    entries = "custom" -- can be "custom", "wildmenu" or "native"
  },
  snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<c-l>'] = cmp.mapping.confirm({ select = true }),
    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
    ['<C-c>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif cmp.has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<C-k>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- vim_item.menu = ({
      --   nvim_lsp = "[L]",
      --   luasnip = "[S]",
      --   buffer = "[B]",
      --   path = "[P]",
      --   treesitter = "[T]",
      -- })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "luasnip", max_item_count = 3,  option = { use_show_condition = false } },
    { name = "nvim_lsp", max_item_count = 7 },
    { name = "buffer", max_item_count = 7 },
    { name = "treesitter", max_item_count = 5 },
    { name = "path" },
  },
  -- confirm_opts = {
  --   behavior = cmp.ConfirmBehavior.Replace,
  --   select = false,
  -- },
  window = {
    documentation = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
  },
  -- experimental = {
  --   ghost_text = false,
  --   native_menu = false,
  -- },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'wildmenu', separator = '|' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path', max_item_count = 10, priority = 3 }
  }, {
    { name = 'cmdline', max_item_count = 10, priority = 5 }
  })
})

-- Setup lspconfig.
-- require('lspconfig')['tsserver'].setup {
  -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- }

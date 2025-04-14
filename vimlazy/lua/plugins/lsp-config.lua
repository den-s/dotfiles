return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    -- enabled = false,
    dependencies = {
      { "saadparwaiz1/cmp_luasnip" },
      -- { "zbirenbaum/copilot-cmp" },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { "kristijanhusak/vim-dadbod-completion"},
    },
    config = function()
      local cmp = require('cmp')
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
          entries = "custom", -- can be "custom", "wildmenu" or "native"
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
          winhighlight = 'normalfloat:telescopenormal,floatborder:telescopeborder',
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
            vim_item.menu = ({
              nvim_lsp = "LSP",
              luasnip = "Snippet",
              buffer = "Buffer",
              path = "Path",
              treesitter = "TreeSitter",
              copilot = "",
              vim_dadbod_completion = "DB",
            })[entry.source.name]
            return vim_item
          end,
        },
        sources = {
          { name = "luasnip",  max_item_count = 3 },
          { name = "nvim_lsp", max_item_count = 7 },
          { name = "copilot",  max_item_count = 2 },
          { name = "buffer", max_item_count = 5 },
          -- { name = "treesitter", max_item_count = 5 },
          { name = "path" },
          { name = "vim-dadbod-completion", max_item_count = 5},
        },
        -- confirm_opts = {
        --   behavior = cmp.ConfirmBehavior.Replace,
        --   select = false,
        -- },
        window = {
          completion = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = 'NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder',
          },
          documentation = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = 'NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder',
          },
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,

    config = function()
      vim.diagnostic.config({
        -- signs = false,
        virtual_text = false,
      })
      vim.diagnostic.config({
        signs = {
  symbols = { error = "☓ ", warn = "☼ ", hint = "★ " },
          text = {
            -- [vim.diagnostic.severity.ERROR] = '✘',
            -- [vim.diagnostic.severity.WARN] = '',
            -- [vim.diagnostic.severity.HINT] = '⚑',
            -- [vim.diagnostic.severity.INFO] = '»',
            -- [vim.diagnostic.severity.ERROR] = '⣿',
            -- [vim.diagnostic.severity.WARN] = '⣶',
            -- [vim.diagnostic.severity.HINT] = '⣤',
            -- [vim.diagnostic.severity.INFO] = '⣀',
            -- [vim.diagnostic.severity.ERROR] = '🯀',
            -- [vim.diagnostic.severity.WARN] = '✴',
            -- [vim.diagnostic.severity.HINT] = '★',
            -- [vim.diagnostic.severity.INFO] = '◌',
            -- [vim.diagnostic.severity.ERROR] = '🞅',
            -- [vim.diagnostic.severity.WARN] = '🞅',
            -- [vim.diagnostic.severity.HINT] = '🞅',
            -- [vim.diagnostic.severity.INFO] = '🞅',
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
          },
        },
      })
      -- local function goto_definition(split_cmd)
      --   local util = vim.lsp.util
      --   local log = require("vim.lsp.log")
      --
      --   local handler = function(_, result, ctx)
      --     if result == nil or vim.tbl_isempty(result) then
      --       local _ = log.info() and log.info(ctx.method, "No location found")
      --       return nil
      --     end
      --
      --     if split_cmd then
      --       vim.cmd(split_cmd)
      --     end
      --
      --     if vim.tbl_islist(result) then
      --       util.jump_to_location(result[1])
      --     else
      --       util.jump_to_location(result)
      --     end
      --   end
      --
      --   return handler
      -- end

      -- local function open_definition_vsplit()
      --   local handler = goto_definition('vsplit')
      --   local params = vim.lsp.util.make_position_params()
      --   vim.lsp.buf_request(0, 'textDocument/definition', params, handler)
      -- end
      --
      -- local function open_definition_newtab()
      --   local handler = goto_definition('tab split')
      --   local params = vim.lsp.util.make_position_params()
      --   vim.lsp.buf_request(0, 'textDocument/definition', params, handler)
      -- end
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
          -- vim.keymap.set('n', 'gdv', function() open_definition_vsplit() end, opts)
          -- vim.keymap.set('n', 'gdt', function() open_definition_newtab() end, opts)
          vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
          vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
          vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
          vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
          vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set('n', '<leader>af', function() vim.lsp.buf.formatting() end, opts)
        end,
      })

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      local border = {
        {"┌", "FloatBorder"},
        {"─", "FloatBorder"},
        {"┐", "FloatBorder"},
        {"│", "FloatBorder"},
        {"┘", "FloatBorder"},
        {"─", "FloatBorder"},
        {"└", "FloatBorder"},
        {"│", "FloatBorder"},
      }
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

    end
  }
}

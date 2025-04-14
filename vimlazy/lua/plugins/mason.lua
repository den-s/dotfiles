return {
  "williamboman/mason-lspconfig.nvim",
  -- lazy=false,
  -- event = 'InsertEnter',
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()

    -- require('mason-lspconfig').setup()

    local function extra_args()
      local virtual = os.getenv("CONDA_PREFIX") or "/usr"
      return { "--python-executable", virtual .. "/bin/python3", true}
    end

    require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:

      -- this first function is the "default handler"
      -- it applies to every language server without a "custom handler"
      -- ['basedpyright'] = function()
      --   require('lspconfig').basedpyright.setup {
      --     settings = {
      --       basedpyright = {
      --         analysis = {
      --           -- Ignore all files for analysis to exclusively use Ruff for linting
      --           ignore = { '*' },
      --           -- typeCheckingMode = 'off',
      --           -- autoSearchPaths = true,
      --           -- diagnosticMode = "openFilesOnly",
      --           -- useLibraryCodeForTypes = true,
      --
      --           -- reportMissingTypeStubs = false,
      --           -- reportUnknownVariableType = false,
      --         },
      --         disableOrganizeImports = true,
      --       },
      --     },
      --   }
      -- end,
      ['pylsp'] = function ()
        require('lspconfig').pylsp.setup {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                pylint = { enabled = false },
                -- jedi_completion = { fuzzy = true },
                rope_autoimport = {
                  enabled = true,
                  code_actions = {
                    enabled = true,
                  },
                  completions = {
                    enabled = true,
                  },
                },
                rope_completion = {
                  enabled = true,
                },
                pylsp_mypy = {
                  enabled = true,
                  -- this will make mypy to use the virtual environment(if activated before runing AstroNvim)
                  -- if not activated then it will use the system python(more specifically /usr/bin/python3)
                  overrides = extra_args(),
                  report_progress = true,
                  live_mode = true,
                },
              }
            }
          }
        }
      end,
      ['ruff'] = function()
        require('lspconfig').ruff.setup {
          trace = 'messages',
          init_options = {
            settings = {
              logLevel = 'debug',
            }
          }
        }
      end,
      ['cssls'] = function()
        require('lspconfig').cssls.setup {
          init_options = {
            provideFormatter = false,
          },
          filetypes = { 'htmldjango', 'css', 'html', 'cscc' },
        }
      end,
      ['html'] = function()
        require('lspconfig').html.setup {
          init_options = {
            provideFormatter = false,
            filetypes = { 'htmldjango', 'html' },
          },
        }
      end,
      ['denols'] = function()
        require('lspconfig').denols.setup {
          filetypes = { 'css', 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'htmldjango' },
        }
      end,
      ['vtsls'] = function()
        require('lspconfig').vtsls.setup {
          filetypes = { 'typescriptreact', 'typescript' },
        }
      end,
      ['jinja'] = function ()
        require('lspconfig').jinja_lsp.setup{
          filetypes = {'htmldjango'}
        }
      end
    }
    end
}

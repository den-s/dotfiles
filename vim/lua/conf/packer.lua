-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  --Themes
  use { "catppuccin/nvim", as = "catppuccin" }
  use { 'shaunsingh/nord.nvim' }
  use { "olimorris/onedarkpro.nvim" }
  use { "folke/tokyonight.nvim" }

  -- Packer can manage itself
  use { 'wbthomason/packer.nvim' }

  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-surround' }
  -- Post-install/update hook with neovim command
  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- Plug 'preservim/nerdcommenter'
  use { 'tpope/vim-unimpaired' }
  use { 'mileszs/ack.vim' }
  use { 'diepm/vim-rest-console' }
  use { 'windwp/nvim-autopairs' }
  use { 'SirVer/ultisnips' }
  --[[ use { 'vim-scripts/indentpython.vim' } ]]
  use { 'tpope/vim-repeat' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'akinsho/bufferline.nvim' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'numToStr/Comment.nvim',
    requires = {
      {'JoosepAlviste/nvim-ts-context-commentstring'},
    }
  }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      -- {'rafamadriz/friendly-snippets'},
    }
  }
  use {"shortcuts/no-neck-pain.nvim", tag = "*" }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use ('nvim-treesitter/playground')
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  use 'nvim-tree/nvim-web-devicons'
end)

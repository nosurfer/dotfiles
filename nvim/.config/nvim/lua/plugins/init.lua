return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "terraform-ls",
        "tflint",
        "gopls",
        "goimports",
        "pyright",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "eslint_d",
        "htmlhint",
        "prettierd",
        "cppcheck",
        "cpplint",
        "ruff",
        "ansible-language-server",
        "yaml-language-server",
        "ansible-lint",
        "yamllint",
        "clangd",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 2000,
      debounce_hours = 12,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      for _, parser in ipairs({ "terraform", "hcl" }) do
        if not vim.tbl_contains(opts.ensure_installed, parser) then
          table.insert(opts.ensure_installed, parser)
        end
      end
      return opts
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.filters = opts.filters or {}
      opts.filters.dotfiles = false
      opts.filters.git_ignored = false
      return opts
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.lint").setup()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.filters = opts.filters or {}
      opts.filters.dotfiles = false
      opts.filters.git_ignored = false

      opts.git = opts.git or {}
      opts.git.ignore = false

      return opts
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}

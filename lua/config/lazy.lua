-- ~/.config/nvim/lua/config/lazy.lua

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins via lazy.nvim
require("lazy").setup({
  spec = {
    -- =========================
    -- LazyVim Core + Extras
    -- =========================
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },

    -- Disable LazyVim mini.icons to avoid conflicts
    { "nvim-mini/mini.icons", enabled = false },

    -- =========================
    -- UI Plugins (icons, tree, bufferline)
    -- =========================
    {
      "nvim-tree/nvim-web-devicons",
      lazy = false,
      config = function()
        require("nvim-web-devicons").setup({
          default = true,
          color_icons = true,
        })
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        view = { side = "right" }, -- NvimTree on the RIGHT
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
            },
          },
        },
      },
      config = function(_, opts)
        require("nvim-tree").setup(opts)
      end,
    },
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        options = {
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = "slant",
        },
      },
      config = function(_, opts)
        require("bufferline").setup(opts)
      end,
    },

    -- =========================
    -- Auto-save Plugin
    -- =========================
    {
      "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup({
          enabled = true,
          trigger_events = { "InsertLeave", "TextChanged" },
          write_all_buffers = false,
          debounce_delay = 135,
        })
      end,
    },

    -- =========================
    -- Disabled / Optional
    -- =========================
    { "folke/trouble.nvim", enabled = false },

    -- =========================
    -- Completion
    -- =========================
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-emoji" },
      opts = function(_, opts)
        table.insert(opts.sources, { name = "emoji" })
      end,
    },

    -- =========================
    -- Telescope
    -- =========================
    {
      "nvim-telescope/telescope.nvim",
      keys = {
        {
          "<leader>fp",
          function()
            require("telescope.builtin").find_files({
              cwd = require("lazy.core.config").options.root,
            })
          end,
          desc = "Find Plugin File",
        },
      },
      opts = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
      },
    },

    -- =========================
    -- LSP Config
    -- =========================
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = { pyright = {} },
      },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = { "jose-elias-alvarez/typescript.nvim" },
      opts = {
        servers = { tsserver = {} },
        setup = {
          tsserver = function(_, opts)
            require("typescript").setup({ server = opts })
            return true
          end,
        },
      },
    },

    -- =========================
    -- Treesitter
    -- =========================
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, { "tsx", "typescript" })
      end,
    },

    -- =========================
    -- Statusline
    -- =========================
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, {
          function()
            return "😄"
          end,
        })
      end,
    },

    -- =========================
    -- Mason
    -- =========================
    {
      "mason.nvim",
      opts = {
        ensure_installed = { "stylua", "shellcheck", "shfmt", "flake8" },
      },
    },

    -- =========================
    -- Snippets
    -- =========================
    { "L3MON4D3/LuaSnip" },
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },

    -- =========================
    -- Global TypeScript / Vite types
    -- =========================
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.tsserver.setup({
          root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
          init_options = {
            typescript = {
              tsdk = vim.fn.stdpath("data") .. "/npm-global/lib/node_modules/typescript/lib",
            },
          },
        })
      end,
    },
  },

  -- =========================
  -- Defaults & performance
  -- =========================
  defaults = {
    lazy = false,
    version = false,
  },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})

-- =========================
-- LSP Diagnostics (live updates)
-- =========================
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = true, -- live errors while typing
  severity_sort = true,
})

-- Keymaps for diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

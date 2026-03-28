-- ~/.config/nvim/lua/config/lazy.lua

-- Bootstrap lazy.nvim
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

require("lazy").setup({
  spec = {

    -- Core
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },

    -- UI
    { "nvim-tree/nvim-web-devicons", lazy = false },
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = { view = { side = "right" } },
    },
    { "akinsho/bufferline.nvim", version = "*", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Auto-save
    {
      "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup({ enabled = true })
      end,
    },

    -- Trouble
    { "folke/trouble.nvim", enabled = true },

    -- Completion
    { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-emoji" } },

    -- Telescope
    { "nvim-telescope/telescope.nvim", opts = { defaults = { layout_strategy = "horizontal" } } },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      opts = { servers = { pyright = {}, ts_ls = {}, tailwindcss = {}, html = {}, cssls = {}, jsonls = {} } },
    },

    -- Mason
    {
      "mason-org/mason.nvim",
      lazy = false,
      config = function()
        require("mason").setup()
      end,
    },
    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "mason-org/mason.nvim" },
      opts = { ensure_installed = { "ts_ls", "pyright", "tailwindcss", "html", "cssls", "jsonls" } },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = { "mason-org/mason.nvim" },
      opts = {
        ensure_installed = { "stylua", "prettier", "black", "shfmt", "markdownlint" },
        auto_update = false,
        run_on_start = true,
      },
    },

    -- Treesitter
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
          "python",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
      },
    },

    -- Formatter
    {
      "mhartington/formatter.nvim",
      lazy = false,
      config = function()
        local formatter = require("formatter")
        formatter.setup({
          filetype = {
            lua = {
              function()
                return {
                  exe = "stylua",
                  args = { "--search-parent-directories", "-i", vim.api.nvim_buf_get_name(0) },
                  stdin = false,
                }
              end,
            },
            javascript = {
              function()
                return { exe = "prettier", args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, stdin = true }
              end,
            },
            typescript = {
              function()
                return { exe = "prettier", args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, stdin = true }
              end,
            },
            python = {
              function()
                return { exe = "black", args = { vim.api.nvim_buf_get_name(0) }, stdin = false }
              end,
            },
          },
        })
        vim.keymap.set("n", "<leader>f", function()
          vim.cmd("Format")
        end)
      end,
    },

    -- Snippets
    { "L3MON4D3/LuaSnip" },
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },

    -- Statusline
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, function()
          return "😄"
        end)
      end,
    },
  },

  defaults = { lazy = false },
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

-- Clipboard (cross-platform)
vim.opt.clipboard = "unnamedplus"
if vim.fn.has("win32") == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
    paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
    cache_enabled = 0,
  }
end

-- Keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<C-n>", function()
  require("trouble").toggle("diagnostics")
end)

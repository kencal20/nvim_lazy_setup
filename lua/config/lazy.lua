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
    -- UI Plugins
    -- =========================
    {
      "nvim-tree/nvim-web-devicons",
      lazy = false,
      config = function()
        require("nvim-web-devicons").setup({ default = true, color_icons = true })
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        view = { side = "right" },
        renderer = {
          icons = { show = { file = true, folder = true, folder_arrow = true } },
        },
      },
      config = function(_, opts) require("nvim-tree").setup(opts) end,
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
      config = function(_, opts) require("bufferline").setup(opts) end,
    },

    -- =========================
    -- Auto-save
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
    -- Trouble.nvim
    -- =========================
    { "folke/trouble.nvim", enabled = true },

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
    { "neovim/nvim-lspconfig", opts = { servers = { pyright = {} } } },
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
          "bash","html","javascript","json","lua","markdown","markdown_inline",
          "python","query","regex","tsx","typescript","vim","yaml",
        },
      },
    },

    -- =========================
    -- Statusline
    -- =========================
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, { function() return "😄" end })
      end,
    },

    -- =========================
    -- Mason (always loaded)
    -- =========================
    {
      "mason.nvim",
      lazy = false,  -- ensures :MasonInstall & binaries exist immediately
      opts = { ensure_installed = { "stylua", "prettier", "black", "shfmt", "markdownlint" } },
    },

    -- =========================
    -- Formatter.nvim
    -- =========================
    {
      "mhartington/formatter.nvim",
      lazy = false,  -- load immediately so :Format works
      dependencies = { "mason.nvim" },
      config = function()
        local formatter = require("formatter")
        formatter.setup({
          logging = false,
          filetype = {
            lua = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/stylua", args = { "--search-parent-directories", "-i", vim.api.nvim_buf_get_name(0) }, stdin = false } end
            },
            javascript = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/prettier", args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, stdin = true } end
            },
            typescript = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/prettier", args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, stdin = true } end
            },
            json = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/prettier", args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, stdin = true } end
            },
            html = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/prettier", args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, stdin = true } end
            },
            css = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/prettier", args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) }, stdin = true } end
            },
            markdown = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/markdownlint", args = { "--fix", vim.api.nvim_buf_get_name(0) }, stdin = false } end
            },
            sh = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/shfmt", args = { "-w", "-i", "2" }, stdin = false } end
            },
            python = {
              function() return { exe = vim.fn.stdpath("data").."/mason/bin/black", args = { vim.api.nvim_buf_get_name(0) }, stdin = false } end
            },
          },
        })

        -- Format keymap
        vim.keymap.set("n", "<leader>f", function() vim.cmd("Format") end, { desc = "Format current buffer" })

        -- Auto-format on save
        vim.cmd([[
          augroup FormatOnSave
            autocmd!
            autocmd BufWritePre * Format
          augroup END
        ]])
      end,
    },

    -- =========================
    -- Snippets
    -- =========================
    { "L3MON4D3/LuaSnip" },
    {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },

    -- =========================
    -- Global TypeScript / Vite types
    -- =========================
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.tsserver.setup({
          root_dir = lspconfig.util.root_pattern("package.json","tsconfig.json",".git"),
          init_options = {
            typescript = { tsdk = vim.fn.stdpath("data").."/npm-global/lib/node_modules/typescript/lib" }
          },
        })
      end,
    },
  },

  defaults = { lazy = false, version = false },
  performance = { rtp = { disabled_plugins = { "gzip","tarPlugin","tohtml","tutor","zipPlugin" } } },
})

-- =========================
-- LSP Diagnostics
-- =========================
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 2 },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

-- Diagnostics keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Trouble toggle
vim.keymap.set("n", "<C-n>", function() require("trouble").toggle("diagnostics") end, { desc = "Toggle Diagnostics" })

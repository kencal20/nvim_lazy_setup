# 💤 LazyVim Neovim Setup

![LazyVim startup screen](assets/lazy.png)

A personal Neovim configuration optimized for **React**, **TypeScript**, **Python**, and general development. Built on [LazyVim](https://github.com/LazyVim/LazyVim) with [Lazy.nvim](https://github.com/folke/lazy.nvim) for modular plugin management.

---

## Table of Contents

- [Overview](#overview)
- [Core Plugins](#core-plugins)
- [Language Support](#language-support)
- [Editor Features](#editor-features)
- [Navigation & Keybindings](#navigation--keybindings)
- [Fuzzy Finder](#fuzzy-finder)
- [LSP & Development Tools](#lsp--development-tools)
- [Snippets](#snippets)
- [Status Line](#status-line)
- [Markdown Preview](#markdown-preview)
- [Installation](#installation)
- [Configuration Notes](#configuration-notes)
- [Contributing](#contributing)
- [References](#references)

---

## Overview

This configuration is designed for fast, productive development in modern web and backend languages. It includes:

- LSP support for TypeScript, JavaScript, Python, HTML, CSS, JSON
- Auto-completion with emoji support
- Live diagnostics and error reporting
- Treesitter syntax highlighting and code folding
- File explorer and bufferline for efficient navigation
- Web-based Markdown preview for documentation editing
- Auto-save functionality

---

## Core Plugins

| Plugin | Purpose |
|--------|---------|
| [LazyVim](https://github.com/LazyVim/LazyVim) | Modular Neovim framework |
| [Lazy.nvim](https://github.com/folke/lazy.nvim) | Lazy-loading plugin manager |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer (right side) |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs in slanted style |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons |
| [auto-save.nvim](https://github.com/Pocco81/auto-save.nvim) | Automatic file saving |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics panel |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Auto-completion engine |

---

## Language Support

### LSP Servers

| Language | Server |
|----------|--------|
| TypeScript/JavaScript | `ts_ls` (tsserver) |
| Python | `pyright` |
| HTML | `html` |
| CSS | `cssls` |
| JSON | `jsonls` |
| TailwindCSS | `tailwindcss` |

### Treesitter Parsers

Installed parsers for enhanced syntax highlighting and code folding:


---

## Editor Features

### Auto-save

- Automatically saves files on leaving insert mode or after text changes
- Does not interfere with LSP diagnostics

### Completion

- `nvim-cmp` with emoji support
- Snippet integration with LuaSnip

### Diagnostics

- Live inline error messages with virtual text
- Gutter signs for errors and warnings
- Underlines for diagnostic highlights
- Severity sorting for better readability

### Formatting

| File Type | Formatter |
|-----------|-----------|
| Lua | stylua |
| JavaScript/TypeScript | prettier |
| Shell | shfmt |
| Markdown | markdownlint |

> **Note**: Python formatting (black) has been removed due to installation issues.

---

## Navigation & Keybindings

![Which-key popup showing leader key shortcuts](assets/which_key_prop.png)


**Leader key** is set to **Space** by default.

### Diagnostics Navigation

| Key | Action |
|-----|--------|
| `<leader>e` | Show floating diagnostic window |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<C-n>` | Toggle Trouble diagnostics panel |

### General Navigation

| Key | Action |
|-----|--------|
| `<leader>f` | Format current file |
| `<leader>v` | Toggle Markdown preview (browser-based) |

---

## Fuzzy Finder

**[Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** for fast file and content searching.

| Key | Action |
|-----|--------|
| `<leader>fp` | Find project/plugin files |
| `<leader>fs` | Search project content (live grep) |

---

## LSP & Development Tools

### Mason.nvim

Ensures essential development tools are automatically installed:

| Tool | Purpose |
|------|---------|
| stylua | Lua formatter |
| prettier | JavaScript/TypeScript formatter |
| shfmt | Shell script formatter |
| markdownlint | Markdown linting |

### Mason-lspconfig

Automatically configures installed LSP servers:



---

## Snippets

- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
- **[friendly-snippets](https://github.com/rafamadriz/friendly-snippets)** - VS Code-style snippet collection

Snippets are automatically loaded and available for all supported file types.

---

## Status Line

**[Lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** with:

- Mode indicator
- File type with icon
- Git branch and status
- File location (line/column)
- Emoji indicator for personality

---

## Markdown Preview

**[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** - Web-based live preview

### Features

- Toggle with `<leader>v` (single keypress, like VS Code)
- Live updates as you edit
- Full CSS/HTML rendering (not just terminal text)
- Opens in your default browser

### Requirements

- Node.js (v16+ recommended)

### Usage

1. Open a `.md` file in Neovim
2. Press `<leader>v`
3. Browser opens with live preview
4. Edit your Markdown - preview updates automatically
5. Press `<leader>v` again to close

---

## Installation

### Prerequisites

- Neovim v0.11 or higher
- Git
- Node.js & npm (for Markdown preview and TypeScript)
- A Nerd Font (for icons)

### Step 1: Clone the Repository

```bash
git clone h### Step 1: Clone the Repository

```bash
# Linux / macOS
git clone https://github.com/kencal20/nvim_lazy_setup.git ~/.config/nvim

# Windows (PowerShell or CMD)
git clone https://github.com/kencal20/nvim_lazy_setup.git %LOCALAPPDATA%\nvimttps://github.com/kencal20/nvim_lazy_setup.git ~/.config/nvim

Launch Nvim(in terminal)
nvim
```

## References

| Plugin | Repository |
|--------|------------|
| LazyVim | [github.com/LazyVim/LazyVim](https://github.com/LazyVim/LazyVim) |
| Lazy.nvim | [github.com/folke/lazy.nvim](https://github.com/folke/lazy.nvim) |
| nvim-tree | [github.com/nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) |
| Telescope | [github.com/nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) |
| Treesitter | [github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) |
| Mason | [github.com/williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) |
| markdown-preview | [github.com/iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) |
| LuaSnip | [github.com/L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) |
| Lualine | [github.com/nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) |

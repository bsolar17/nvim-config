# Neovim Config

Minimal, modular, and plugin-oriented Neovim configuration.

- **Entry point:** `init.lua` → `lua/my-setup/`
- **Plugin manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)

## Layout

- `lua/my-setup/` — basic initial setup, required at startup
- `lua/plugins/` — lazy.nvim plugin specs
- `lua/my-lib/` — helper modules, required on demand
- `lua/my-plugins/` — local plugins, loaded by lazy via `dir =`

## External Tools

Some external tools are required or recommended:

- **git** — required for plugin management and version control
- **fzf** — required by search/fuzzy finder features
- **ripgrep (rg)** — required for live grep and file search
- **tree-sitter-cli** - required for treesitter plugins
- **fd** — optional, for faster file finding
- **npm** — for installing certain Node-based plugins
- **stylua** — for Lua formatting
- **jdtls** — for Java language support (Mason install)
- **java-test** — for Java testing (Mason install)
- **java-debug-adapter** — for Java debug (Mason install)

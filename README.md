# Neovim Config

Minimal, modular, and plugin-oriented Neovim configuration.

- **Entry point:** `init.lua` → `lua/my-setup/`
- **Plugin manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Modular settings:** in `lua/my-setup/`
- Supports both native Neovim and VSCode plugin use

## External Tools

Some external tools are required or recommended:

- **git** — required for plugin management and version control
- **fzf** — required by search/fuzzy finder features
- **ripgrep (rg)** — required for live grep and file search
- **fd** — optional, for faster file finding
- **npm** — for installing certain Node-based plugins
- **stylua** — for Lua formatting
- **jdtls** — for Java language support (Mason install)
- **java-test** — for Java testing (Mason install)
- **java-debug-adapter** — for Java debug (Mason install)

# GitHub Copilot Instructions

## Context

- Project Description: Neovim configuration 
- Languages: Lua
- Frameworks: lazy.nvim

## Project Structure

- `lua/my-plugins/`: Custom local plugins implementations.
- `lua/my-setup/`: Basic lazy.nvim setup and Neovim configuration.
- `lua/plugins-all`: Plugins configuration loaded in all cases.
- `lua/plugins-nvim`: Plugins configuration loaded in standalone Neovim
- `lua/plugins-vscode`: Plugins configuration loaded in Neovim running in Visual
Studio Code

## General Guidelines

- Create new plugin configuration files in `lua/plugins-nvim` by default.
- Creatie a separate Lua file per plugin, except when the plugins are strongly
coupled.
- Chop down large tables.
- Chop down long parameter lists.
- Always add `,` to the last element of a chopped-down table.
- Use 80 characters textwidth.
- Use `"` to quote strings, except to avoid escaping.
- Use `local` variables.
- Ensure code is properly formatted after editing.

## Commands

### Code Formatting

```sh
stylua .
```

# Project-specific clangd

Neovim's `exrc` option is enabled, so a trusted project can extend the runtime
path from a repository-local `.nvim.lua`:

```lua
vim.opt.runtimepath:append(".nvim")
```

Put that project's clangd settings in `.nvim/lsp/clangd.lua`:

```lua
return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--compile-commands-dir=build",
  },
}
```

Change `build` to the directory containing the project's
`compile_commands.json`. Review the local file, open Neovim in the project,
then use `:trust` to approve it.

# dotfiles-public

Stow-managed terminal configuration for a lab server, based on
[omerxx/dotfiles](https://github.com/omerxx/dotfiles) at commit
`97b2213ad0e61c7a036290752e23497920978d55`.

The matching configurations from the source repository are retained and placed
into conventional per-tool Stow packages. Personal paths and identifiers are
removed, and source-repo tools not selected in `todo.md` are omitted.

## Retained from the source repository

- Atuin
- Ghostty (macOS only)
- Neovim + LazyVim
- Starship
- Television and its channels
- tmux, Catppuccin, Floax, and supporting tmux plugins
- Zsh behavior adapted to be portable

The shell also enables the config-free tools from `todo.md` when installed:
`eza`, `zoxide`, `fzf`, `fd`, `rg`, `sesh`, `mise`, and `direnv`. The source
repository has no Yazi configuration, so the tracked local Yazi theme was
adapted to Catppuccin Mocha. Sesh uses the source repository's Television
channel through the tmux `prefix` + `T` popup.

Neovim enables LazyVim's clangd extra and trusted project-local configuration.
See [`docs/project-clangd.md`](docs/project-clangd.md) for the `.nvim.lua` and
per-project clangd layout. Gitsigns remains enabled through LazyVim core.

## Omitted source-repo tools

These are not part of the server tool list:

```text
aerospace gh-dash hammerspoon karabiner kindavim nix nix-darwin
nushell opencode sketchybar skhd ssh wezterm zellij
```

## Server programs

Install these through the lab-supported package manager:

```text
git stow zsh tmux nvim
fd rg fzf eza zoxide
atuin starship sesh television yazi
zsh-autosuggestions zsh-syntax-highlighting
jj mise direnv
```

The Television executable is named `tv`. On some Linux distributions, `fd` is
packaged as `fdfind`.

Install the matching Yazi flavor once after Yazi is available:

```sh
ya pkg install
```

## Install on the server

```sh
git clone https://github.com/jae8259/dotfiles-public.git ~/.dotfiles
cd ~/.dotfiles
make dry-run
make server
make check
```

The Zsh package deliberately does not replace `~/.zshrc`, because managed
servers often provide an important site-wide shell setup. Add this line to the
end of the existing server `~/.zshrc` instead:

```sh
[[ -r "$HOME/.config/zsh/dotfiles.zsh" ]] && source "$HOME/.config/zsh/dotfiles.zsh"
```

Do not use `stow --adopt` to resolve existing-file conflicts: it can copy the
server's files back into this Git checkout. Back up conflicting Git or Neovim
configuration first, and then run `make server` again.

Install tmux plugins on first use:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then start tmux and press `prefix` + `I`. The prefix is `Ctrl-a`.

Remove the server links with:

```sh
make unstow
```

## macOS

Install Ghostty and a Nerd Font locally on the Mac, then run:

```sh
make mac
```

Ghostty is not installed on the server. Its SSH integration handles remote
terminfo setup.

Remove both Mac and server links with:

```sh
make unstow-mac
```

## Personal settings

The Git package contains the existing personal Git configuration and the Zsh
package contains the Git aliases previously sourced by Home Manager.
Machine-specific shell additions can remain untracked in `~/.zshrc.local`.
Machine-specific Git identity can be set in the untracked
`~/.gitconfig.local`, which is included after the shared Git configuration.

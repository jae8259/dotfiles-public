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
`eza`, `zoxide`, `fzf`, `fd`, `rg`, `sesh`, `mise`, and `direnv`. Yazi needs no
configuration here yet because the source repository does not provide one.
Sesh uses the source repository's Television channel through the tmux
`prefix` + `T` popup.

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
mise direnv
```

The Television executable is named `tv`. On some Linux distributions, `fd` is
packaged as `fdfind`.

## Install on the server

```sh
git clone https://github.com/jae8259/dotfiles-public.git ~/.dotfiles
cd ~/.dotfiles
make dry-run
make server
make check
```

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

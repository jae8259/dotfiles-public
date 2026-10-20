# dotfiles-public

Small, portable dotfiles for a lab server and macOS. GNU Stow manages the
symlinks; the operating system or environment manager installs the programs.

Inspired by [omerxx/dotfiles](https://github.com/omerxx/dotfiles), with the
macOS automation, cloud tooling, security tooling, Nix, and tmux plugins
removed.

## Server tools

Required:

```text
git stow zsh tmux nvim fd rg fzf eza zoxide starship
```

`fd` may be packaged as `fdfind` on some Linux distributions. If that is the
case, make a user-local `fd` symlink or alias according to the distribution's
instructions.

## macOS-only tools

- Ghostty
- A Nerd Font, if you choose to use icons later

Ghostty runs on the Mac, not on the server. Its configuration enables SSH
terminfo integration for remote hosts.

## Install

Clone the repository anywhere, then preview the server links:

```sh
git clone https://github.com/jae8259/dotfiles-public.git ~/.dotfiles
cd ~/.dotfiles
make dry-run
```

Create the server links:

```sh
make server
make check
```

On a Mac, also link the Ghostty configuration:

```sh
make mac
```

If Stow reports a conflict, move the existing file aside and run the command
again. Do not use `stow --adopt` unless you intend to copy the existing file
into this repository.

Remove the server links with:

```sh
make unstow
```

On a Mac, remove both the Ghostty and server links with:

```sh
make unstow-mac
```

## Local settings

Machine-specific or secret shell configuration belongs in `~/.zshrc.local`.
Git identity belongs in `~/.gitconfig.local`:

```ini
[user]
    name = Your Name
    email = you@example.com
```

Neither local file is tracked by this repository.

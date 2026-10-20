STOW := stow --target=$(HOME)
SERVER_PACKAGES := git zsh tmux nvim starship atuin television rg yazi
MAC_PACKAGES := ghostty

.PHONY: server mac dry-run unstow unstow-mac check

server:
	$(STOW) --restow $(SERVER_PACKAGES)

mac: server
	$(STOW) --restow $(MAC_PACKAGES)

dry-run:
	$(STOW) --no --verbose $(SERVER_PACKAGES)

unstow:
	$(STOW) --delete $(SERVER_PACKAGES)

unstow-mac:
	$(STOW) --delete $(MAC_PACKAGES)
	$(STOW) --delete $(SERVER_PACKAGES)

check:
	@for tool in git stow zsh tmux nvim fd rg fzf eza zoxide atuin starship sesh tv yazi mise direnv; do \
		if command -v $$tool >/dev/null 2>&1; then \
			printf 'ok       %s\n' $$tool; \
		else \
			printf 'missing  %s\n' $$tool; \
		fi; \
	done
	@for plugin in zsh-autosuggestions zsh-syntax-highlighting; do \
		if test -n "$$CONDA_PREFIX" && test -r "$$CONDA_PREFIX/share/zsh/plugins/$$plugin/$$plugin.zsh"; then \
			printf 'ok       %s\n' $$plugin; \
		else \
			printf 'missing  %s\n' $$plugin; \
		fi; \
	done

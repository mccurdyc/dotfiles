default: help

TOOLS_DIR=$(HOME)/.tools
HEADLESS?=true
DOTFILES=$(CURDIR)/files.headless

.PHONY: install-tools
install-tools: ## Installs the necessary tools for setup.
	@./scripts/install-tools.sh

.PHONY: replace-templated-text
replace-templated-text: install-tools ## Replaces templated text.
ifeq ($(HEADLESS),false)
	DOTFILES=$(CURDIR)/files
endif
	@./scripts/replace-templated-text.sh -d $(DOTFILES)

.PHONY: fetch-keys
fetch-keys: install-aur-deps ## Fetches GPG, etc. keys.
	@./scripts/fetch-keys.sh

.PHONY: run
run: install-official-deps install-aur-deps dotfiles config-deps fetch-keys ## Runs the full necessary (not additional/optional) setup.

.PHONY: create-files
create-files: ## Creates required files that don't need to be symlinked to dotfiles
	touch $(HOME)/.zsh_history

.PHONY: dump-deps
dump-deps: ## Creates a dump of your currently-installed dependencies.
	@# https://superuser.com/questions/1061612/how-do-you-make-a-list-file-for-pacman-to-install-from
	@pacman -Qqne > pkglist-official.txt
	@pacman -Qqme > pkglist-aur.txt

.PHONY: install-aur-pkg-mgr
install-aur-pkg-mgr: install-official-deps ## Installs the yay AUR package manager.
	./scripts/install-yay.sh $(TOOLS_DIR)

.PHONY: install-official-deps
install-official-deps: ## Installs official packages.
ifeq ($(HEADLESS),true)
	sudo pacman -S --noconfirm - < pkglist-official.txt.headless
else
	sudo pacman -S --noconfirm - < pkglist-official.txt
endif

.PHONY: recv-keys
recv-keys: ## Downloads the necessary GPG keys for verifying packages.
	@# 1password-cli - https://support.1password.com/getting-started-linux/#arch-linux
	gpg --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22

.PHONY: install-aur-deps
install-aur-deps: recv-keys ## Installs AUR packages.
ifeq ($(HEADLESS),true)
	yay -S --answerclean All --answerdiff None --removemake --noconfirm - < pkglist-aur.txt.headless
else
	yay -S --answerclean All --answerdiff None --removemake --noconfirm - < pkglist-aur.txt
endif

.PHONY: dotfiles
dotfiles: ## Symlinks the dotfiles to $(HOME) (idempotent).
	@./scripts/symlink.sh -v -d $(DOTFILES) -o $(HOME)
	@./scripts/symlink.sh -d $(DOTFILES) -o $(HOME)
ifeq ($(HEADLESS),false)
	DOTFILES=$(CURDIR)/files
	@./scripts/symlink.sh -v -d $(DOTFILES) -o $(HOME)
	@./scripts/symlink.sh -d $(DOTFILES) -o $(HOME)
endif

.PHONY: config-deps
config-deps: install-tools ## Runs the necessary commands to configure the installed packages.
	nvim +PlugInstall +UpdateRemotePlugins +qall
	@ # TODO update - nvim --headless -c "CocInstall coc-snippets"
	@# https://github.com/tmux-plugins/tpm/issues/6
	@# sudo npm i -g bash-language-server

.PHONY: asdf-tools
asdf-tools: ## Installs tools managed via asdf-vm.
	./scripts/asdf-tools.sh .asdf-tools

.PHONY: chmod
chmod: ## Makes necessary files executable.
	chmod +x $(HOME)/.xinitrc;

.PHONY: symlink
symlink: chmod ## Creates the necessary symlinks.
	sudo ln -snf $(CURDIR)/etc/bluetooth /etc/bluetooth
	sudo ln -snf $(CURDIR)/etc/pacman.conf /etc/pacman.conf
	ln -snf $(CURDIR)/.config/mimeapps.list $(HOME)/.local/share/applications/mimeapps.list
	ln -snf $(CURDIR)/.Xresources $(HOME)/.Xdefaults;
	@# yes, we want xsessionrc symlinked to xinitrc
	@# https://faq.i3wm.org/question/18/how-do-xsession-xinitrc-and-i3config-play-together.1.html
	ln -snf $(CURDIR)/.xinitrc $(HOME)/.xsessionrc;
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore;
	mkdir -p $(HOME)/Pictures/screenshots;
	# ln -snf $(CURDIR)/CustomCSSforFx/custom $(CURDIR)/.mozilla/firefox/99ijjp0g.default-release/chrome

.PHONY: help
help: ## Prints this help menu.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

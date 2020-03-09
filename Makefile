default: help

TOOLS_DIR=$(HOME)/tools

.PHONY: run-minimal
run-minimal: install-official-deps dotstar symlink ## Runs the full necessary (not additional/optional) setup.

.PHONY: run-full
run-full: install-official-deps install-aur-pkg-mgr install-aur-deps dotstar symlink config-deps ## Runs the full setup (i.e., necessary plus optional).

.PHONY: install-aur-pkg-mgr
install-aur-pkg-mgr: install-official-deps ## Installs the yay AUR package manager.
	mkdir $(TOOLS_DIR)
	git clone https://aur.archlinux.org/yay.git $(TOOLS_DIR)/yay
	cd $(TOOLS_DIR)/yay
	makepkg -si

.PHONY: install-official-deps
install-official-deps: ## Installs official packages.
	@#https://superuser.com/questions/1061612/how-do-you-make-a-list-file-for-pacman-to-install-from
	sudo pacman -S - < pkglist-official.txt

.PHONY: install-aur-deps
install-aur-deps: ## Installs AUR packages.
	@#https://superuser.com/questions/1061612/how-do-you-make-a-list-file-for-pacman-to-install-from
	sudo pacman -S - < pkglist-aur.txt

.PHONY: dump-deps
dump-deps: ## Creates a dump of your currently-installed dependencies.
	@# https://superuser.com/questions/1061612/how-do-you-make-a-list-file-for-pacman-to-install-from
	@pacman -Qqne > pkglist-official.txt
	@pacman -Qqme > pkglist-aur.txt

.PHONY: config-deps
config-deps: ## Runs the necessary commands to configure the installed packages.
	nvim +PlugInstall +UpdateRemotePlugins +qall > /dev/null
	@# https://github.com/tmux-plugins/tpm/issues/6
	$(HOME)/.tmux/plugins/tpm/scripts/install_plugins.sh
	tmux source $(HOME)/.tmux.conf
	sudo npm i -g bash-language-server

.PHONY: dotstar
dotstar: ## Symlinks the dotfiles to $(HOME)
	for file in $(shell find $(CURDIR) -maxdepth 1 -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \

.PHONY: chmod
chmod: ## Makes necessary files executable.
	chmod +x $(HOME)/.xinitrc;
	sudo chmod +x /etc/rc.local;

.PHONY: symlink
symlink: chmod ## Creates the necessary symlinks.
	@# yes, we want xsessionrc symlinked to xinitrc
	@# https://faq.i3wm.org/question/18/how-do-xsession-xinitrc-and-i3config-play-together.1.html
	ln -snf $(CURDIR)/.Xresources $(HOME)/.Xdefaults;
	ln -snf $(CURDIR)/.xinitrc $(HOME)/.xsessionrc;
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore;
	sudo ln -sfn $(CURDIR)/etc/rc.local /etc/rc.local;
	sudo ln -sfn $(CURDIR)/etc/systemd/system/rc-local.service /etc/systemd/system/rc-local.service;
	mkdir -p $(HOME)/Pictures/screenshots;
	ln -snf $(CURDIR)/detroit-street-art.jpg $(HOME)/Pictures/detroit-street-art.jpg;

.PHONY: enable
enable: ## Enables services to be run on startup.
	-@sudo systemctl enable rc-local.service;
	-@sudo systemctl start rc-local.service;

.PHONY: help
help: ## Prints this help menu.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

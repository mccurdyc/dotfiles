default: help

.PHONY: run
run: install-deps dotstar chmod symlink ## Runs the full setup.

.PHONY: install-deps
install-deps: ## Installs packages.
	sudo pacman -S - < pkglist.txt

.PHONY: dump-deps
dump-deps: ## Creates a dump of your currently-installed dependencies to be used by the `install-deps` target.
	pacman -Qqen > pkglist.txt

.PHONY: config-deps
config-deps: ## Runs the necessary commands to configure the installed packages.
	nvim +PlugInstall +qall > /dev/null

.PHONY: dotstar
dotstar: ## Symlinks the dotfiles to $(HOME)
	for file in $(shell find $(CURDIR) -maxdepth 1 -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \

.PHONY: chmod
chmod: ## Makes necessary files executable.
	chmod +x $(HOME)/.xinitrc;

.PHONY: symlink
symlink: ## Creates the necessary symlinks.
	# yes, we want xsessionrc symlinked to xinitrc
	# https://faq.i3wm.org/question/18/how-do-xsession-xinitrc-and-i3config-play-together.1.html
	ln -snf $(CURDIR)/.Xresources $(HOME)/.Xdefaults;
	ln -snf $(CURDIR)/.xinitrc $(HOME)/.xsessionrc;
	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;

	mkdir -p $(HOME)/Pictures/screenshots;
	ln -snf $(CURDIR)/detroit-street-art.jpg $(HOME)/Pictures/detroit-street-art.jpg;
	# https://wiki.archlinux.org/index.php/XDG_MIME_Applications#mimeapps.list
	ln -s ~/.config/mimeapps.list /usr/share/applications/mimeapps.list;

.PHONY: help
help: ## Prints this help menu.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

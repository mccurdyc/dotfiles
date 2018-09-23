# run Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

exec i3

# source zprofile
# without this, zsh looks terrible
if [ -f ~/.zprofile ]; then
	. ~/.zprofile
fi

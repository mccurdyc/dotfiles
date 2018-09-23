# run Xprofile
if [ -f ~/.Xprofile ]; then
	# shellcheck source=/dev/null
	. ~/.Xprofile
fi

# run Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

exec i3

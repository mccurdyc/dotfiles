# run Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# fix palm scrolling while typing
synclient PalmMinZ=100

exec i3

# set background image
eval `cat $HOME/.fehbg`

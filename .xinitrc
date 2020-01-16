# run Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

exec i3

# set background image
eval `cat $HOME/.fehbg`

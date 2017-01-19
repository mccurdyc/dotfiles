# Terminal.app, which runs a login shell by default
# for each new terminal window,
# calling .bash_profile instead of .bashrc

 #if running bash

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
fi

# Ruby version
if which rbenv > /dev/null;
      then eval "$(rbenv init -)";
fi
export PATH="$HOME/.rbenv/bin:$PATH"

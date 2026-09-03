# Bash reads this file for login shells and ~/.bashrc for interactive
# non-login shells. An SSH session is a login shell, so source ~/.bashrc
# here to make both cases behave the same.
[ -f ~/.bashrc ] && . ~/.bashrc

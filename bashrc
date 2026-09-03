# bash entry point for machines without zsh as the login shell (the Ubuntu box).
# Kept deliberately thin: it reuses the same files zsh uses.

# Stock Ubuntu bits worth keeping.
case $- in
  *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE=32768
shopt -s histappend checkwinsize

[ -f ~/.bashrc.local ] && . ~/.bashrc.local

command -v fzf > /dev/null 2>&1 && eval "$(fzf --bash)"

# Shared with zsh: starship prompt.
[ -f ~/.shellrc.shared ] && . ~/.shellrc.shared

# zsh sets these in zsh/configs/editor.zsh, which bash never reads.
# ~/.aliases needs them, so set them first.
export VISUAL=vim
export EDITOR=$VISUAL

# Shared with zsh: aliases (thoughtbot's ~/.aliases sources ~/.aliases.local).
[ -f ~/.aliases ] && . ~/.aliases

# mkdir .git/safe in the root of repositories you trust
PATH="$HOME/.bin:.git/safe/../../bin:$PATH"
export PATH

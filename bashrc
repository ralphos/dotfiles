# bash entry point for machines without zsh as the login shell (the Ubuntu box).
# Kept deliberately thin: it reuses the same files zsh uses.

# Environment for EVERY bash shell: login, interactive, and non-interactive
# (`ssh box 'some command'`). Machine-specific PATH entries and tokens go in
# ~/.bashenv.local, which is not tracked here. This must run before the
# interactive check below, or non-interactive shells never see it.
#
# Note: once ~/.bash_profile exists, bash ignores ~/.profile entirely. Anything
# that used to live in ~/.profile belongs in ~/.bashenv.local instead.
[ -f ~/.bashenv.local ] && . ~/.bashenv.local

# Stop here unless the shell is interactive.
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

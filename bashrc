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

# PATH for every bash shell. Personal directories first, only when they exist;
# mise shims so Ruby resolves in non-interactive shells too. Prepend once.
for _dir in "$HOME/.bin" "$HOME/bin" "$HOME/.local/bin" \
            "${XDG_DATA_HOME:-$HOME/.local/share}/mise/shims"; do
  case ":$PATH:" in
    *":$_dir:"*) ;;
    *) [ -d "$_dir" ] && PATH="$_dir:$PATH" ;;
  esac
done
unset _dir
# mkdir .git/safe in the root of repositories you trust
case ":$PATH:" in
  *":.git/safe/../../bin:"*) ;;
  *) PATH=".git/safe/../../bin:$PATH" ;;
esac
export PATH

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

# fzf keybindings. `fzf --bash` needs fzf 0.48+; Ubuntu 24.04 ships 0.44, which
# instead installs the same files under /usr/share.
if command -v fzf > /dev/null 2>&1; then
  if fzf --bash > /dev/null 2>&1; then
    eval "$(fzf --bash)"
  else
    [ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && . /usr/share/doc/fzf/examples/key-bindings.bash
    [ -f /usr/share/bash-completion/completions/fzf ] && . /usr/share/bash-completion/completions/fzf
  fi
fi

# Shared with zsh: starship prompt.
[ -f ~/.shellrc.shared ] && . ~/.shellrc.shared

# zsh sets these in zsh/configs/editor.zsh, which bash never reads.
# ~/.aliases needs them, so set them first.
export VISUAL=vim
export EDITOR=$VISUAL

# Shared with zsh: aliases (thoughtbot's ~/.aliases sources ~/.aliases.local).
[ -f ~/.aliases ] && . ~/.aliases


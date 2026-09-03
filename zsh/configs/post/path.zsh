# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

# Personal bin directories, added only when they actually exist.
for _dir in "$HOME/bin" "$HOME/.local/bin" "$HOME/.codeium/windsurf/bin" \
            "${XDG_DATA_HOME:-$HOME/.local/share}/mise/shims"; do
  [ -d "$_dir" ] && PATH="$_dir:$PATH"
done
unset _dir

export -U PATH

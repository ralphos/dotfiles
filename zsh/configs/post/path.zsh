# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# Try loading ASDF from the regular home dir location
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
elif which brew >/dev/null && [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
  . "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

# Personal bin directories, added only when they actually exist.
for _dir in "$HOME/bin" "$HOME/.local/bin" "$HOME/.codeium/windsurf/bin"; do
  [ -d "$_dir" ] && PATH="$_dir:$PATH"
done
unset _dir

export -U PATH

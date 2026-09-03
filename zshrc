# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  # The globs below use the `~` exclusion operator, which needs extendedglob.
  # options.zsh turns it on, but that file is loaded BY this function, so set
  # it locally here or the pre/ and post/ loops match nothing.
  setopt local_options extendedglob
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Machine-specific config, not tracked in this repo.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Cross-shell config shared with bash. The starship prompt lives here.
# Loaded last so nothing can overwrite PROMPT.
[[ -f ~/.shellrc.shared ]] && source ~/.shellrc.shared

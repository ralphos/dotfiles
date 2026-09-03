# Runs before zsh/configs/post/path.zsh on purpose: `brew shellenv` re-runs
# macOS path_helper, which would otherwise push /usr/local/bin back in front of
# ~/.bin and the other personal directories path.zsh puts first.
# zprofile already did this for login shells; skip if so.
if [ -z "$HOMEBREW_PREFIX" ]; then
  if [ "$(uname -m)" = "arm64" ] && [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

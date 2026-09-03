# Homebrew lives in /opt/homebrew on Apple Silicon and /usr/local on Intel.
# Choose by architecture, not by directory existence: an old, unused
# /opt/homebrew tree can otherwise shadow the working install.
if [ "$(uname -m)" = "arm64" ] && [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

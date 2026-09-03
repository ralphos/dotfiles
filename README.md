Ralph's dotfiles
================

Shell, editor, git and terminal configuration for macOS and Ubuntu.
Managed with [rcm](https://github.com/thoughtbot/rcm).

Install
-------

    git clone git@github.com:ralphos/dotfiles.git ~/dotfiles
    ln -sf ~/dotfiles/rcrc ~/.rcrc
    ~/dotfiles/bin/setup-shell-tools
    rcup

`rcup` symlinks each file into your home directory. Run it again any time to
pick up new files. Use `rcup -f` to replace files that already exist, such as
the stock `~/.bashrc` on a fresh Ubuntu box.

`setup-shell-tools` installs the command line tools these files expect. It uses
Homebrew on macOS and apt on Debian or Ubuntu.

What is in here
---------------

| Path | Installs to | What it does |
| --- | --- | --- |
| `zshrc`, `zshenv`, `zprofile`, `zsh/` | `~/.zshrc`, `~/.zsh/` | zsh: history, completion, keybindings, PATH |
| `bashrc`, `bash_profile` | `~/.bashrc`, `~/.bash_profile` | bash entry points, reuse the same aliases and prompt |
| `shellrc.shared` | `~/.shellrc.shared` | starts starship in whichever shell is running |
| `aliases` | `~/.aliases` | shell aliases, including eza and bat |
| `config/starship.toml` | `~/.config/starship.toml` | the prompt, themed after Vesper |
| `config/herdr/config.toml` | `~/.config/herdr/config.toml` | herdr theme and tmux-style keys |
| `tmux.conf` | `~/.tmux.conf` | tmux: `C-a` prefix, vi keys, Vesper colours |
| `vimrc`, `vimrc.bundles`, `vim/` | `~/.vimrc`, `~/.vim/` | vim and its plugins |
| `gitconfig`, `gitignore`, `git_template/` | `~/.gitconfig` etc. | git config, aliases and hooks |
| `bin/` | `~/.bin/` | small helper scripts, on your PATH |
| `Brewfile` | `~/.Brewfile` | `brew bundle --global` on macOS |

Machine-specific config
-----------------------

Anything that belongs to one machine only goes in a `.local` file. These are
**not** tracked here. Create them by hand where you need them.

    ~/.aliases.local        ~/.gitconfig.local
    ~/.zshrc.local          ~/.tmux.conf.local
    ~/.vimrc.local          ~/.vimrc.bundles.local
    ~/.bashenv.local        ~/.bashrc.local

`~/.bashenv.local` is read by every bash shell, including non-interactive
ones, so it is the place for PATH entries and tokens on a bash machine. Once
`~/.bash_profile` exists, bash no longer reads `~/.profile`, so move anything
from there into `~/.bashenv.local`.

Credits
-------

Large parts of this started life in
[thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles), MIT licensed.
See `LICENSE`.

Ralph's dotfiles
===============

I use [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) and
ralphos/dotfiles together using the `*.local` convention described in
thoughtbot/dotfiles.

Requirements
------------

Set zsh as your login shell.

    chsh -s /bin/zsh

Install [rcm](https://github.com/mike-burns/rcm).

    brew tap mike-burns/rcm
    brew install rcm

Install
-------

Clone onto your laptop:

    git clone git://github.com/ralphos/dotfiles.git

Install:

    rcup -d dotfiles -x README.md

This will create symlinks for config files in your home directory.

You can safely run `rcup` multiple times to update.

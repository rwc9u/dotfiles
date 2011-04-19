
Clone this (or a forked version of this) repository, and update all the git submodules within.

    $ cd ~
    $ git clone https://rwc9u@github.com/rwc9u/dotfiles.git dotfiles
    $ cd dotfiles
    $ git submodule update --init --recursive

Run `install.rb` to symlink non-dotted files in the main directory to their .dot file counterparts in your home directory.

    $ cd ~/dotfiles
    $ ./install.rb


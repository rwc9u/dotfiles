## Installation
This mainly contains my dotfile and emacs configuration that I use on my development machines.

### Install Xcode

* Install [Xcode](https://developer.apple.com/xcode/)
* Install Xcode command line tools
```bash
$ xcode-select --install
```

### Install Homebrew 
* Install [homebrew](https://brew.sh/)
```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
### Install rvm
* Install [rvm](https://rvm.io)
```
$ curl -sSL https://get.rvm.io | bash -s stable
```

### Dotfile and Emacs Configuration
Clone this (or a forked version of this) repository, and update all the git submodules within.

    $ cd ~
    $ git clone https://rwc9u@github.com/rwc9u/dotfiles.git dotfiles
    $ cd dotfiles
    $ git submodule update --init --recursive

Run `install.rb` to symlink non-dotted files in the main directory to their .dot file counterparts in your home directory.

    $ cd ~/dotfiles
    $ ./install.rb

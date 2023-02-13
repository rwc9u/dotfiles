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
### Install oh-my-zsh
* Install [oh-my-zsh](https://ohmyz.sh)
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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



### Brew Bundle
* Install my gotos
```
$ cd ~/dev/dotfiles
$ brew bundle
```

### Install P10k
* Install [powerlevel10k](https://github.com/romkatv/powerlevel10k)

``` bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

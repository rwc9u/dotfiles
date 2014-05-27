############################################################
## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi


############################################################
## PATH
############################################################

if [ -d ~/bin ] ; then
  PATH="~/bin:./bin:${PATH}"
fi

# DarwinPorts
if [ -d /opt/local/bin ] ; then
  PATH="/opt/local/bin:${PATH}"
fi
if [ -d /opt/local/sbin ] ; then
  PATH="/opt/local/sbin:${PATH}"
fi

if [ -d /usr/local/bin ] ; then
  PATH="/usr/local/bin:${PATH}"
fi


# MySql
if [ -d /usr/local/mysql/bin ] ; then
  PATH="${PATH}:/usr/local/mysql/bin"
fi

# Postgres
if [ -d /opt/local/lib/postgresql91/bin ] ; then
  PATH="${PATH}:/opt/local/lib/postgresql91/bin"
fi

# Python
PATH=${PATH}:/usr/local/share/python

# Heroku
if [ -d /usr/local/heroku/bin ] ; then
  PATH="${PATH}:/usr/local/heroku/bin"
fi

PATH=.:${PATH}


############################################################
## Other paths
############################################################

# Set MANPATH so it includes users' private man if it exists
# if [ -d ~/man ]; then
#   MANPATH="~/man:${MANPATH}"
# fi
MANPATH="/opt/local/man:/opt/local/share/man:${MANPATH}"

# Set INFOPATH so it includes users' private info if it exists
# if [ -d ~/info ]; then
#   INFOPATH="~/info:${INFOPATH}"
# fi


############################################################
## Terminal behavior
############################################################

# Change the window title of X terminals 
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac

# Show the git branch and dirty state in the prompt.
# Borrowed from: http://henrik.nyh.se/2008/12/git-dirty-prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\)/"
}

# Do not set PS1 for dumb terminals
if [ "$TERM" != 'dumb'  ] && [ -n "$BASH" ]
then
  export PS1='\[\033[32m\]\n[\s: \w] $(parse_git_branch) (rvm: $(~/.rvm/bin/rvm-prompt i v s g))\n\[\033[31m\][\u@\h]\$ \[\033[00m\]'
fi


############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
export EDITOR="vi"


############################################################
## History
############################################################

# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend

export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
# remove duplicates from the history (when a new item is added)
export HISTCONTROL=erasedups
# increase the default size from only 1,000 items
export HISTSIZE=10000

# By default up/down are bound to previous-history and next-history
# respectively. The following does the same but gives the extra functionality
# where if you type any text (or more accurately, if there is any text between
# the start of the line and the cursor), the subset of the history starting with
# that text is searched.
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward


############################################################
## Aliases
############################################################
 
if [ -e ~/.bash_aliases ] ; then
  . ~/.bash_aliases
fi


############################################################
## Bash Completion, if available
############################################################

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
elif  [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif  [ -f /etc/profile.d/bash_completion ]; then
  . /etc/profile.d/bash_completion
fi


############################################################
## Other
############################################################

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

############################################################
## Setting up rvm for multiple ruby envs
############################################################
if [[ -s /Users/rchristie/.rvm/scripts/rvm ]] ; then source /Users/rchristie/.rvm/scripts/rvm ; fi
[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

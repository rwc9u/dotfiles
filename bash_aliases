# Adds an alias to the current shell and to this file.
# Borrowed from Mislav (http://github.com/mislav/dotfiles/tree/master/bash_aliases)
add-alias ()
{
   local name=$1 value=$2
   echo "alias $name='$value'" >> ~/.bash_aliases
   eval "alias $name='$value'"
   alias $name
}
 
############################################################
## List
############################################################
 
if [[ `uname` == 'Darwin' ]]; then
  alias ls="ls -G"
  # good for dark backgrounds
  export LSCOLORS=gxfxcxdxbxegedabagacad
else
  alias ls="ls --color=auto"
  # good for dark backgrounds
  export LS_COLORS='no=00:fi=00:di=00;36:ln=00;35:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;31:'
  # For LS_COLORS template: $ dircolors /etc/DIR_COLORS
fi
 
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
 
############################################################
## Git
############################################################
 
alias g="git"
alias gb="git branch -a -v"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gd="git diff"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gs="git status"
alias gsr="git cherry -v trunk"
alias gg="git log --pretty=oneline"
alias ggs="git log --stat"
alias gsl="git shortlog -s -n"
 
# Useful report of what has been committed locally but not yet pushed to another
# branch. Defaults to the remote origin/master. The u is supposed to stand for
# undone, unpushed, or something.
function gu {
  local branch=$1
  if [ -z "$1" ]; then
    branch=master
  fi
  if [[ ! "$branch" =~ "/" ]]; then
    branch=origin/$branch
  fi
  local cmd="git cherry -v $branch"
  echo $cmd
  $cmd
}
 
function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}
 
function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status
  fi
}
 
############################################################
## Subversion
############################################################
 
# Remove all .svn folders from directory recursively
alias svn-clean='find . -name .svn -print0 | xargs -0 rm -rf'
 
############################################################
## OS X
############################################################
 
# Get rid of those pesky .DS_Store files recursively
alias dstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'
 
# Track who is listening to your iTunes music
alias whotunes='lsof -r 2 -n -P -F n -c iTunes -a -i TCP@`hostname`:3689'
 
############################################################
## Ruby
############################################################
 
alias a="autotest"
 
export GEMS=/opt/local/lib/ruby/gems/1.8/gems
function findgem {
  echo `ls $GEMS | grep -i $1 | sort | tail -1`
}
 
# Use: cdgem <name>, cd's into your gems directory
# that best matches the name provided.
function cdgem {
  cd $GEMS/`findgem $1`
}
 
# Use: gemdoc <gem name>, opens the rdoc of the gem
# that best matches the name provided.
function gemdoc {
  open $GEMS/../doc/`findgem $1`/rdoc/index.html
}

alias rvmcompletion="[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion"
 
############################################################
## Rails
############################################################
 
alias ss="script/server"
alias sg="script/generate"
alias sc="script/console"
alias rails3="rvm use ruby-1.9.2-head@rails3"
 
############################################################
## Miscellaneous
############################################################
 
alias wgeto="wget -q -O -"
alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"
 
############################################################

############################################################
## nginx
############################################################
alias nginx_restart='nginx_stop; nginx_start'
alias nginx_start='sudo /opt/nginx/sbin/nginx'
alias nginx_stop='sudo kill `cat /opt/nginx/logs/nginx.pid `'
alias passenger_qryptograph='passenger start -a 127.0.0.1 -p 3003 -d'
alias passenger_qryptograph_stop='passenger stop --port 3003'
alias passenger_urlstalker='passenger start -a 127.0.0.1 -p 3001 -d'
alias passenger_retirehq='passenger start -a 127.0.0.1 -p 3004 -d'

alias mongod_start='mongod run --config /usr/local/etc/mongod.conf'
# mongod run --config /usr/local/Cellar/mongodb/2.0.2-x86_64/mongod.conf
# alias mongod_start='sudo mongod --fork --logpath /var/log/mongodb.log --logappend'
# alias mongod_cleanup="sudo rm /data/db/mongod.lock && sudo mongod --repair"
############################################################
## postgres
############################################################
alias pgstart="sudo su postgres -c '/opt/local/lib/postgresql91/bin/pg_ctl -D /opt/local/var/db/postgresql91/defaultdb -l /opt/local/var/db/postgresql91/defaultdb/logfile start'"
alias pgstop="sudo su postgres -c '/opt/local/lib/postgresql91/bin/pg_ctl -D /opt/local/var/db/postgresql91/defaultdb stop -m fast'"
alias pgstatus="sudo su postgres -c '/opt/local/lib/postgresql91/bin/pg_ctl status -D /opt/local/var/db/postgresql91/defaultdb'"

############################################################
## bundler 
############################################################
alias b="bundle"
alias bi="b install --path vendor"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

############################################################
## coffee
############################################################
alias emacs_coffee="export NODE_NO_READLINE=1 && coffee"

alias E="SUDO_EDITOR=\"emacsclient -c -a emacs\" sudo -e"
# slightly modified version which takes care of relative paths:
# function E() {
# filename=$1
# without_beg_slash="${1##/}"
# if [[ $without_beg_slash == $1 ]];then
# filename="${PWD%//}/$1"
# fi
# emacsclient -c -a emacs "/sudo:root@localhost:$filename"
# }


############################################################
## JobOn
############################################################
## Staging
alias jobon-staging-ssh-wowza='ssh ec2-user@ec2-23-20-229-103.compute-1.amazonaws.com'
alias jobon-staging-ssh-solr='ssh ec2-user@ec2-107-22-148-36.compute-1.amazonaws.com'
alias jobon-staging-redis='redis-cli -h tetra.redistogo.com -p 9210 -a 3deae8694cf3b9eb7548b7ff213239af'
alias jobon-staging-logs-tail='heroku logs -t --app jobon-staging'
alias jobon-staging-console='heroku run console --app jobon-staging'
alias jobon-staging-psql='heroku pg:psql --app jobon-staging'
alias jobon-staging-config='heroku config --app jobon-staging'

## Production
alias jobon-production-ssh-wowza='ssh ec2-user@174.129.31.138'
alias jobon-production-ssh-solr='ssh ec2-user@107.21.99.188'
alias jobon-production-redis='redis-cli -h barracuda.redistogo.com -p 9149 -a 52116ab441654d629e6641ba59cceb8c'
alias jobon-production-logs-tail='heroku logs -t --app jobon'
alias jobon-production-console='heroku run console --app jobon'
alias jobon-production-psql='heroku pg:psql --app jobon'
alias jobon-production-config='heroku config --app jobon'
alias ware-production-ssh-wowza='ssh -l ec2-user -i ~/.ssh/jobon_production.pem 54.225.120.17'

alias socialv="source .powenv && be foreman start"

alias browserstack="java -jar BrowserStackTunnel.jar u8YSVjSTSO7ny5XqQ75z diamond.dev,80,0"

alias elasticsearch_start="elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml"

alias kill-sidekiq="killall -9 -m sidekiq"
# ~/.bash_profile: executed by bash for login shells.

if [ -e ~/.bashrc ] ; then
  . ~/.bashrc
fi

# Local customizations go below

if [ -e ~/.bash_env ] ; then
  . ~/.bash_env
fi

# private customizations go below
if [ -e ~/.bash_priv_env ] ; then
  . ~/.bash_priv_env
fi


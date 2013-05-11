
#   Table of Contents
#
#   1.  Path Manipulation
#   2.  Aliases
#   3.  Prompt Adjustments
# --------------------------------------------------------------



#   1.  Path Manipulation
# --------------------------------------------------------------

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin

# RVM
export PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# NODE Js
export NODE_PATH=/usr/local/bin

# NVM
[[ -s /Users/stevensloan/.nvm/nvm.sh ]] && . /Users/stevensloan/.nvm/nvm.sh


#   2.  Aliases
# --------------------------------------------------------------

alias flushdns="dscacheutil -flushcache; echo 'done';"
alias apache="sudo apachectl"
alias pythonserver="python -m SimpleHTTPServer 8000"
alias middleman_pid="lsof -w -n -i tcp:4567"

if hash hub 2>/dev/null; then
  alias git=hub
fi


#   3.  Prompt Adjustments
# --------------------------------------------------------------

# Set Colours for Folders
export CLICOLOR=1
export LSCOLORS=AxExFxFxfxaxaxaxaxaxax

# Git branch completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Prompt formatter
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}

function proml {
  local  GREEN="\[\033[0;32m\]"
  local  EMK="\[\033[1;30m\]"
  local  DEFAULT="\[\033[0m\]"

  PS1="\W$GREEN\$(parse_git_branch)$EMK →$DEFAULT "
}

proml

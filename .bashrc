#   Table of Contents
#
#   1.  Path Manipulation
#   2.  Aliases
#   3.  Prompt Adjustments
# --------------------------------------------------------------


#   1.  Path Manipulation
# --------------------------------------------------------------

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# NODE Js
export NODE_PATH=/usr/local/bin

# NVM
[[ -s /Users/stevensloan/.nvm/nvm.sh ]] && . /Users/stevensloan/.nvm/nvm.sh

# PHP/Composer
export PATH="~/.composer/vendor/bin:$PATH"

# RVM
export PATH="$PATH:$HOME/.rvm/bin"

# Add Dotrepo
export PATH="$PATH:$HOME/.dotrepo/bin"


#   2.  Aliases
# --------------------------------------------------------------

alias flushdns="dscacheutil -flushcache; echo 'done';"
alias apache="sudo apachectl"
alias pythonserver="python -m SimpleHTTPServer 8000"
alias server="ruby -run -e httpd . -p5000"
alias middleman_pid="lsof -w -n -i tcp:4567"
alias response_time="curl -o /dev/null -s -w '%{time_total}\\n'"
alias chrome="open /Applications/Google\ Chrome.app"
alias subldots="subl `dotrepo repo`"
alias clear_logs="sudo rm -rf /private/var/log/asl/*.asl"
alias fe="rustc"
alias difff="git diff --color | diff-so-fancy"
alias tab="open . -a iterm"

function delete_remote_tag {
  git push --delete origin $1
}

function delete_merged_branches {
  git branch --merged |
  egrep -v "(^\*|master|dev)" |
  while read -r line; do
    echo -n "Delete branch '$line'? (N|y) "
    read answer < /dev/tty

    if [[ "$answer" == "y" ]]; then
      git branch -d "$line"
    fi
  done
}

function mkpwd {
  if [[ -z "$1" ]]; then
    length=12
  else
    length="$1"
  fi

  openssl rand -base64 "$length"
}

function kill_middleman {
  middleman_pid | grep -m 1 'ruby' | perl -pe 's/ruby\s+(\d+)(.+)/$1/g' | xargs kill -9
}

function mkcd {
  mkdir -p $1 && cd $1
}

### rails workflows

# http://robots.thoughtbot.com/workflows-for-writing-migrations-with-rollbacks-in-mind

function migrate {
  rake db:migrate db:rollback
  if [ $? -eq 0 ] ; then
    rake db:migrate db:test:prepare
    try_annotate
  fi
}

function try_annotate {
  if hash annotate 2>/dev/null; then
    annotate
  else
    echo '"annotate" is unavailable. consider installing the gem'
  fi
}


### alias git to hub

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

function parse_git_status {
  # check if we're in a git repo
  is_git=`git status 2> /dev/null`
  if [ -z "$is_git" ] ; then
    return 1
  fi

  # check if there are changes
  status=`git status 2> /dev/null | grep "nothing to commit"`
  dirty_marker="Δ"

  if [ "$status" != "nothing to commit, working directory clean" ] ; then
    echo " $dirty_marker"
  fi
}

function format_prompt {
  local  GREEN="\[\e[32m\]"
  local  EMK="\[\e[30m\]"
  local  TEAL="\[\e[36m\]"
  local  DEFAULT="\[\e[0m\]"

  export PS1="\W$GREEN\$(parse_git_branch)$TEAL\$(parse_git_status)$EMK → $DEFAULT"
}
format_prompt

# load .bashrc.local if it exists
if [ -f ~/.bashrc.local ]; then
   source ~/.bashrc.local
fi

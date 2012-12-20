## git completion (run brew install bash-completion first)
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export CLICOLOR=1
export LSCOLORS=AxExFxFxfxaxaxaxaxaxax

## branch name in prompt
function parse_git_branch {

        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

}

function proml {

  local       GREEN="\[\033[0;32m\]"
  local     EMK="\[\033[1;30m\]"
  local     DEFAULT="\[\033[0m\]"

PS1="\W$GREEN\$(parse_git_branch)$EMK →$DEFAULT "

}

proml

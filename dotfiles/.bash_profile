## git completion (run brew install bash-completion first)
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

## branch name in prompt
function parse_git_branch {

        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

}

function proml {

  local       GREEN="\[\033[0;32m\]"

  local     DEFAULT="\[\033[0m\]"

PS1="\W$GREEN\$(parse_git_branch) $DEFAULT\$ "

}

proml

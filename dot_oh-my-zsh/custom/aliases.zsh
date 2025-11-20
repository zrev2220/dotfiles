# npm
alias npmversion='npm version --no-git-tag-version'
alias getver='jq -r .version package.json'
alias getverb='jq -r '"'"'"\(.version) (\(.buildNo))"'"'"' package.json'
# pnpm
alias pi='pnpm i'
alias px='pnpm nx'
alias pionic='pnpm -F mobile exec ionic'
# poetry
alias getverp='poetry version -s'
alias poi='poetry install'
# uv
alias us='uv sync'
# pre-commit
alias pc='pre-commit run --all-files'
# git
alias commitver='git commit -am "chore: $(getver)"'
alias commitverb='git commit -am "chore: $(getver) (build $(jq -r .buildNo package.json))"'
alias commitverp='git commit -am "chore: $(getverp)"'
alias tagver='git tag "v$(getver)"'
alias tagverp='git tag "v$(getverp)"'
alias gitpushtags='git push && git push --tags'
alias gitbranchsa='for branch in $(git branch -r | grep -v HEAD);do git show --color --no-patch --format="%an~%ai~%ar~%C(yellow)%h%Creset~%S" $branch; done | sort | column -s "~" -t'
alias gitbranchsd='for branch in $(git branch -r | grep -v HEAD);do git show --color --no-patch --format="%ai~%ar~%an~%C(yellow)%h%Creset~%S" $branch; done | sort | column -s "~" -t'
alias gsubl='GIT_EDITOR="subl -w"'
# vs cli
alias vsgt='vs get-token | tee /dev/tty | xclip -sel clip'
# vpn
alias vpnup='openvpn3 session-start --config zhayes'
alias vpndown='openvpn3 session-manage --config zhayes --disconnect'
# misc
alias sa='alias | rg'
alias img='chafa -f kitty'
alias bel='echo -e -n "\07"'
if command -v xclip > /dev/null; then
  alias clp='xclip -sel clip'
fi

glb () {
  # print issues for a GitLab user, grouped by workflow::* label
  user=$1

  reset="\e[0m"
  labels=(
    "workflow::backlog"
    "workflow::to-do"
    "workflow::doing"
    "workflow::review"
  )
  labelColors=(
    "\e[40m"
    "\e[30;43m"
    "\e[30;42m"
    "\e[30;44m"
  )

  echo
  for ((i = 1; i <= $#labels; i++)); do
    label=${labels[$i]}
    labelColor=${labelColors[$i]}
    echo -e "${labelColor}${label}${reset}\n"
    glab issue list -g vs -a $user -l $label
  done
}

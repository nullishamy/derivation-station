mkdir ~/.cache/starship
starship init nu 
    | str replace "term size -c" "term size" 
    | str replace --all "let-env " "$env." 
    | save -f ~/.cache/starship/init.nu

mkdir ~/.cache/atuin
atuin init nu --disable-up-arrow 
    | save -f ~/.cache/atuin/init.nu

mkdir ~/.cache/zoxide
zoxide init nushell
  | str replace --all "-- $rest" "-- ...$rest" 
  | str replace "--interactive -- $rest" "--interactive -- ...$rest" 
  | save -f ~/.cache/zoxide/init.nu

# from https://www.nushell.sh/cookbook/misc.html#manage-ssh-passphrases
# and https://github.com/nushell/nushell/discussions/9192

$env.SSH_AGENT_TIMEOUT = 300
mkdir ~/.cache/ssh-agent/

if ("~/.cache/ssh-agent/agent" | path exists) {
  let ssh_env = (open ~/.cache/ssh-agent/agent | from json)

  let nc = (do { ^nc -zU $ssh_env.SSH_AUTH_SOCK } | complete)
  let sock_exit = $nc.exit_code

  if ($sock_exit == 0) {
    $ssh_env | load-env
  } else {
    let ssh_env = (ssh-agent -c -t $env.SSH_AGENT_TIMEOUT
    | lines
    | first 2
    | parse "setenv {name} {value};"
    | transpose -i -r -d)

    $ssh_env | to json | save -f ~/.cache/ssh-agent/agent
    $ssh_env | load-env
  }
} else {
  let ssh_env = (ssh-agent -c -t $env.SSH_AGENT_TIMEOUT
  | lines
  | first 2
  | parse "setenv {name} {value};"
  | transpose -i -r -d)

  $ssh_env | to json | save ~/.cache/ssh-agent/agent
  $ssh_env | load-env
}

if ("~/.ssh/github" | path exists ) {
  do { ssh-add ~/.ssh/github } o+e> /dev/null
}

source ~/.config/nushell/env-nix.nu

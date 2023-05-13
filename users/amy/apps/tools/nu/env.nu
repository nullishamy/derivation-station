mkdir ~/.cache/starship
starship init nu | str replace "term size -c" "term size" | save -f ~/.cache/starship/init.nu
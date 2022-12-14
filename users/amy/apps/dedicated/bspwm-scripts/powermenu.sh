#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-1"
theme='style-1'

# CMDs
# uptime="`uptime | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown='shutdown'
reboot='reboot'
lock='lock'
suspend='suspend'
logout='logout'
yes='yes'
no='no'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$host" 
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-dmenu \
		-p 'confirm' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}'
		# -theme-str 'element-text {horizontal-align: 0.5;}' \
		# -theme-str 'mainbox {children: [ "message", "listview" ];}' \
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			bspc quit
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
        i3lock -c 282828
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac

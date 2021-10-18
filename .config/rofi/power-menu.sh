#!/usr/bin/env sh
#
# A rofi powered menu to execute power related action.
# Uses: amixer mpc poweroff reboot rofi rofi-prompt

power_off='shutdown'
reboot='reboot'
lock='lock'
suspend='suspend'
log_out='log out'

chosen=$(printf '%s;%s;%s;%s;%s\n' "$power_off" "$reboot" "$lock" "$suspend" \
                                   "$log_out" \
    | rofi -theme 'power.rasi' \
           -dmenu \
           -sep ';' \
           -selected-row 0)

case "$chosen" in
    "$power_off")
        poweroff
        ;;

    "$reboot")
        reboot
        ;;

    "$lock")
        i3lock --blur 5 --clock
        ;;

    "$suspend")
        amixer set Master mute 
        systemctl suspend
        ;;

    "$log_out")
        i3-msg exit
        ;;

    *) exit 1 ;;
esac

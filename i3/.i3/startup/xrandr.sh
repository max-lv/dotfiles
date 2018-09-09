#!/usr/bin/env sh

xrandr --output HDMI-0 --pos 0x0
sleep 1
xrandr --output DVI-I-0 --pos 2000x160
sleep 1
xrandr --output HDMI-0 --primary

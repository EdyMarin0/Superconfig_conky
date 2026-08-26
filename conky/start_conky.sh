#!/bin/bash
conky -c ~/.config/conky/conky.conf &
sleep 0.1
xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -name "ConkyMain"

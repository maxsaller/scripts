#!/bin/bash
#
# Determines the resolution of the screen and calculates the centre point
#

x=`xdpyinfo | grep "dimensions" | cut -d ' ' -f7 | cut -d 'x' -f1`
y=`xdpyinfo | grep "dimensions" | cut -d ' ' -f7 | cut -d 'x' -f2`

halfx=$(($x / 2))
halfy=$(($y / 2))

quartx=$(($x / 4))
quarty=$(($y / 4))

echo ${x} 'x' ${y}
echo Centre ${halfx},${halfy}

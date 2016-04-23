#!/bin/bash
#put this code in /etc/rc.local to execute at boot
mount /dev/mmcblk0p2 / -o remount,ro #prevent SD card corruption by mounting read only
mount proc /proc -t proc #as this is executed just after the kernel has finished booting, /proc doesn't exist. This creates it.
tvservice -o #Turn off HDMI
stty -F /dev/ttyAMA0 9600 #set the baudrate of the slice of radio
gpio -g mode 27 down #configure internal pullups
gpio -g mode 22 down
gpio -g mode 23 down
gpio -g mode 24 down
TTY=/dev/ttyAMA0 
while true; do
A=0 
B=0
C=0
D=0
[[ $(gpio -g read 27) == 1 ]] && A=1 #forward  
[[ $(gpio -g read 22) == 1 ]] && B=2 #backward
[[ $(gpio -g read 23) == 1 ]] && C=4 #right
[[ $(gpio -g read 24) == 1 ]] && D=8 #left
SWSTATE=$(($A+$B+$C+$D))
case $SWSTATE in
0)
echo "aAASTOP-----" > $TTY #stop and center, as there is no  input on any switch
echo "aAACENTER---" > $TTY
sleep 0.5
;;
1)
echo "aAAFORWARD--" > $TTY
echo "aAACENTER---" > $TTY
;;
2)
echo "aAABACKWARD-" > $TTY
echo "aAACENTER---" > $TTY
;;
4)
echo "aAASTOP-----" > $TTY
echo "aAARIGHT----" > $TTY
;;
5)
echo "aAAFORWARD--" > $TTY
echo "aAARIGHT----" > $TTY
;;
6)
echo "aAABACKWARD-" > $TTY
echo "aAARIGHT----" > $TTY
;;
8)
echo "aAASTOP-----" > $TTY
echo "aAALEFT-----" > $TTY
;;
9)
echo "aAAFORWARD--" > $TTY
echo "aAALEFT-----" > $TTY
;;
10)
echo "aAABACKWARD-" > $TTY
echo "aAALEFT-----" > $TTY
;;
*)
echo "DEBUG: $SWSTATE" #print to a debug terminal if therei s an unknown option
;;
esac
done

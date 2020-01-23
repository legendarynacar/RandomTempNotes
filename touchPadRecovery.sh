#!/bin/bash
# If your touch pad's double finger usage like scrolling stops working after sleep in linux, in my situation Ubuntu 18.04, these commands will help.
# Basically what it does is removing the touchpad module in kernel and re-adds it.
# Solution is found in StackExchange as usual : https://askubuntu.com/questions/1170327/touch-pads-two-finger-scrolling-not-working-after-sleep-sometimes-in-lenovo-thi
# And yes, mine is Lenovo Thinkpad too but model E580.

if [[ $EUID -ne 0 ]]
then
    #echo "Devam edebilmem için root yetkisi ile çalıştırılmam lazım!"
    #echo -e "\e[5m\e[1m\e[31mDevam edebilmem için root yetkisi ile çalıştırılmam lazım!\e[0m"
    echo -e "\e[5m\e[1m\e[31mTo continue, I need to be run as ROOT!!!\e[0m"
    exit 1
else
    echo "Removing Touch Pad Module. Be WARNED! You will not able to use your touchpad and ThinkPad Red Dot if you have."
    modprobe -r psmouse
    echo "Removed. Now re-adding it.. Wait a sec!"
    modprobe psmouse
    sleep 3
    echo "Done. You should able to use it."
fi

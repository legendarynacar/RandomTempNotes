#!/bin/bash
: '
This script is for changing default (aka Internet) routing.

It is not fully thought on to prevent any (im)possible damage to the system. The algorithm is designed to solve my problem.
'
echo -e "\e[1m### \e[1m\e[31mWelcome To Default Route Changer | DRC \e[0m \e[1m###\e[0m\n"

echo -e "\e[1m\e[31mCurrent Default Route Table\e[0m\n"
echo -e "`ip route | grep default`\n"


unique_interface_number=`ip route | grep default | cut -d' ' -f5 | sort -u | wc -l`

interface_list=()

for i in `ip route | grep default | cut -d' ' -f5`
do
    interface_list+=($i)
done

sayi=0
dublicate_sayisi=0

for i in `ip route | grep default | cut -d' ' -f5 | sort -u`
do
    sayi=$(($sayi+1))
    if [[ $i = ${interface_list[$sayi]} ]]
    then
        echo -e "$i arayuzunden bir tane daha cikti\n"
        dublicate_sayisi=$(($dublicate_sayisi+1))
    fi
done

if [[ $dublicate_sayisi -gt 0 ]]
then
    echo -e "I am not written to handle this type of case, to not damage your system I must QUIT!\n"
    exit 1
fi

echo -e "\n\e[1m\e[31mDetected interfaces:\e[0m\n"
echo -e "\t\e[1m${interface_list[@]}\e[0m\n"
who_is_in_charge=""
lowest_metric_owner=""
lowest_metric_owner_value=999999

for i in ${interface_list[@]}
do
    current_metric=`ip route | grep default | grep $i | cut -d' ' -f9`
    if [[ $current_metric -lt $lowest_metric_owner_value ]]
    then
        lowest_metric_owner=$i
        lowest_metric_owner_value=$current_metric
    fi
done

echo -e "It looks like \e[1m\e[31m$lowest_metric_owner\e[0m has the lowest metric value which is \e[1m\e[31m$lowest_metric_owner_value\e[0m \n"
echo -e "This means that your Internet traffic is going through on \e[1m\e[31m$lowest_metric_owner\e[0m\n"
echo -e "Do you wish to change it? [\e[1mYes/No\e[0m] \n"

read input
case $input in
    [yY]*)
        echo -e '\n\e[1mDevam ediliyor\e[0m\n'
        ;;
    [nN]*)
        echo -e '\n\e[1mTamam, kendimi durduruyorum\e[0m\n'
        exit 1
        ;;
    *)
        echo -e '\n\e[1mTanimlanmayan girdi, tekrar deneyin\e[0m\n' >&2
esac

echo -e "Hangi arayuzu one alacaksiniz? Durdurulmami istiyorsan \e[1mEXIT\e[0m yaz.\n"

read girilen_interface_adi

while true
do
    for i in ${interface_list[@]}
    do
        case $girilen_interface_adi in
            $i)
                echo -e "\nDogru arayuz ismi girdiniz, devam edebiliriz!\n"
                break
                ;;
            [Ee][Xx][Ii][Tt]*)
                echo -e "\n\e[1mKendimi sonlandiriyorum\e[0m\n"
                exit 1
                ;;
        esac
    done
break
done

degistirilecek_conf=`ip route | grep default | grep $girilen_interface_adi`
eklenecek_conf=`ip route | grep default | grep $girilen_interface_adi | cut -d' ' -f1-8`

echo -e "\e[1mSilinen deger : $degistirilecek_conf\e[0m\n"
sudo ip route del $degistirilecek_conf

sleep 3

echo -e "\e[1mEklenen deger : $eklenecek_conf\e[0m\n"
sudo ip route add $eklenecek_conf $((lowest_metric_owner_value-1))

sleep 3

echo -e "\e[1mNew Default Route Table\e[0m\n"
ip route | grep default


echo -e "\e[1m\e[31mITS DONE\e[0m\n"
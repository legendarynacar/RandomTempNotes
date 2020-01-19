#!/bin/bash
# Eğer yanıp sönme gibi efektleri istemiyor iseniz, efektsiz olanları yorum olarakta ekledim. Kullanılan efekt ve kodunuda aşağıya yazıyorum.
# `\e[5m` : Blink/Yanıp Sönme efekti
# `\e[1m` : Kalın Punto Efekti
# `\e[31m` : Kırmızı Font Renk Efekti
# `\e[0m` : Bütün efektleri sıfırlama. Bunu kullanma sebebimiz; efekt kodu girildiğinde, sadece echo içerisini değil, devamındaki bütün çıktıları etkiliyor.
# Bu yuzden her satır sonunda sıfırlama yaptım.
if [[ $EUID -ne 0 ]]
then
    #echo "Devam edebilmem için root yetkisi ile çalıştırılmam lazım!"
    echo -e "\e[5m\e[1m\e[31mDevam edebilmem için root yetkisi ile çalıştırılmam lazım!\e[0m"
    exit 1
else
    #echo "Sistem Güncellemesi Başlıyor."
    echo -e "\e[5m\e[1m\e[31mSistem Güncellemesi Başlıyor.\e[0m"
    echo -e "\n"
    sleep 1
    #echo "Paket Listesi Güncelleniyor!"
    echo -e "\e[5m\e[1m\e[31mPaket Listesi Güncelleniyor!\e[0m"
    echo -e "\n"
    apt-get update

    echo -e "\n"
    #echo "Kullanılmayan Parçalar Siliniyor!"
    echo -e "\e[5m\e[1m\e[31mKullanılmayan Parçalar Siliniyor!\e[0m"
    echo -e "\n"
    apt-get autoclean -y
    apt-get autoremove -y

    echo -e "\n"
    #echo "Paket Yükseltmesi Yapılıyor!"
    echo -e "\e[5m\e[1m\e[31mPaket Yükseltmesi Yapılıyor!\e[0m"
    echo -e "\n"
    apt-get upgrade -y

    echo -e "\n"
    #echo "İşletim Sistem Yükseltmesi Yapılıyor!"
    echo -e "\e[5m\e[1m\e[31mİşletim Sistem Yükseltmesi Yapılıyor!\e[0m"
    echo -e "\n"
    apt-get dist-upgrade -y

    echo -e "\n"
    sleep 1
    #echo "Güncelleme Tamamlandı."
    echo -e "\e[5m\e[1m\e[31mGüncelleme Tamamlandı.\e[0m"
fi

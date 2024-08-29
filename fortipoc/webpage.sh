#! /bin/bash


sudo groupadd www
sudo useradd -g fortinet www
sudo usermod -a -G www fortinet
sudo chown -R :www /var/www
sudo chmod -R g+rwX /var/www
sudo chmod g+s /var/www
sudo find /var/www -type d -exec chmod g+s '{}' \;

sudo cp -r /home/fortinet/lxc_srvr_package-main/fortipoc/* /var/www/html/
sudo mkdir /etc/bind/zones
sudo touch /etc/bind/zones/db.unisase.lab
sudo cp /home/fortinet/lxc_srvr_package-main/fortipoc/db.unisase.lab /etc/bind/zones/db.unisase.lab
sudo cat /home/fortinet/lxc_srvr_package-main/fortipoc/named.conf.local >> /etc/bind/named.conf.local
sudo cp /home/fortinet/lxc_srvr_package-main/fortipoc/named.conf.options /etc/bind/named.conf.options
sudo systemctl restart bind9

sudo echo "$(curl -s https://secure.eicar.org/eicar.com)" > /home/fortinet/lxc_srvr_package-main/fortipoc/files/eicar.com.txt
sudo cat /home/fortinet/lxc_srvr_package-main/fortipoc/file_server.txt >> /etc/apache2/apache2.conf
sudo systemctl restart apache2
#! /bin/bash


#sudo apt-get update -y
#sudo apt-get install apache2 -y
#sudo systemctl start apache2
#sudo systemctl enable apache2

sleep 2m

sudo apt-get install -y bind9

sudo groupadd www
sudo useradd -g azureadmin www
sudo usermod -a -G www azureadmin
sudo chown -R :www /var/www
sudo chmod -R g+rwX /var/www
sudo chmod g+s /var/www
sudo find /var/www -type d -exec chmod g+s '{}' \;

sudo cp -r /home/azureadmin/fortipoc/* /var/www/html/
sudo mkdir /etc/bind/zones
sudo touch /etc/bind/zones/db.unisase.lab
sudo cp /home/azureadmin/fortipoc/db.unisase.lab /etc/bind/zones/db.unisase.lab
sudo cat /home/azureadmin/fortipoc/named.conf.local >> /etc/bind/named.conf.local
sudo cp /home/azureadmin/fortipoc/named.conf.options /etc/bind/named.conf.options
sudo systemctl restart bind9

sudo echo "$(curl -s https://secure.eicar.org/eicar.com)" > /home/azureadmin/fortipoc/files/eicar.com.txt
sudo cat /home/azureadmin/fortipoc/file_server.txt >> /etc/apache2/apache2.conf
sudo systemctl restart apache2
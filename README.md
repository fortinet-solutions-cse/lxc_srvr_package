A template package for LXC servers. Suitable for cloun_init opps when runnig terraform. 

Idea behind this is to contain all the services one LXC server needs to have to server the SASE LAB. 
Some of the services added: 
- file server 
- web server 
- DNS server 
- app server 

... more to come 


cloud_init example: 

locals {
  linux_vm_cloud_init = <<-EOT
#! /bin/bash

sudo apt-get update -y
sudo apt-get dist-upgrade
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt-get install -y curl
sudo apt-get install -y bind9

curl -o /home/azureadmin/ https://raw.githubusercontent.com/yourusername/yourrepository/main/fortipoc

sudo chmod +x /home/azureadmin/fortipoc/webpage.sh

sudo /home/azureadmin/fortipoc/webpage.sh

sed -i -e 's/XYZ123/${var.node_name}/g' /var/www/html/index.html

EOT
}

resource "azurerm_linux_virtual_machine" "vm" {
....
  custom_data                     = base64encode(local.linux_vm_cloud_init)
...

}

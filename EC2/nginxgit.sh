# setup Nginx server and hosting GitHub repo 

#!/bin/bash

# Update package list
sudo apt update -y

# Install Nginx
sudo apt install -y nginx git

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Clone your GitHub static site (Replace with your repo URL)
cd /var/www/html
sudo rm -rf /var/www/html/*
sudo git clone https://github.com/ankan24/Login_Chitkara.

# Set correct permissions
sudo chmod -R 755 /var/www/html

# Restart Nginx to apply changes
sudo systemctl restart nginx



sudo mv /var/www/html/Login_Chitkara/* /var/www/html/
sudo rm -rf /var/www/html/Login_Chitkara

# setup Nginx server

#!/bin/bash

sudo apt update -y

sudo apt install -y nginx

systemctl start nginx

systemctl enable nginx
	
echo "hello world ${hostname}"> /var/www/html/index.html

systemctl restart nginx

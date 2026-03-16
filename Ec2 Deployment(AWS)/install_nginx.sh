#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo '<h1 style="color:red; text-align:center;">
Nginx has been installed and started successfully.
</h1>' | sudo tee /var/www/html/index.html 
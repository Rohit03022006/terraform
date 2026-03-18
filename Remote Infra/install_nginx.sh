#!/bin/bash

echo "Updating package list..."
sudo apt update -y

echo "Installing Nginx..."
sudo apt install nginx -y

echo "Starting Nginx service..."
sudo systemctl start nginx

echo "Enabling Nginx on boot..."
sudo systemctl enable nginx

echo "Checking Nginx status..."
sudo systemctl status nginx

echo "Nginx installation completed successfully!"
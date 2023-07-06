#!/bin/bash

sudo apt update -y && 
sudo apt install -y nginx
echo "Deploying Nginx using Terraform is fun!" > /var/www/html/index.html
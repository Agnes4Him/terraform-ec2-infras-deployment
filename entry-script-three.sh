#!/bin/bash


sudo apt update && sudo apt install -y docker.io
sudo systemctl start docker
sudo docker run --name terraform-nginx -p 8080:80 -d -v /home/ubuntu/html:/usr/share/nginx/html nginx

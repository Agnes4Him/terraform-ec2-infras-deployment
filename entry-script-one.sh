#!/bin/bash

sudo apt update && sudo apt install -y docker.io
sudo systemctl start docker
sudo docker run -p 8080:80 nginx

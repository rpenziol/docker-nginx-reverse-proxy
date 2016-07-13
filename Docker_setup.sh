#!/bin/sh

#Install Docker
curl -sSL https://get.docker.com/ | sudo sh

#Add running user to Docker group
sudo groupadd docker
sudo usermod -aG docker $(echo $USER)

#Install Docker-compose
sudo apt-get -y install python-pip
sudo pip install -U docker-compose

#Pull and run containers in background
sudo docker-compose up -d

#Install nginx and copy config
sudo apt-get install -y nginx
sudo cp nginx_config /etc/nginx/sites-enabled/default
echo '127.0.0.1    website1.com' | sudo tee -a /etc/hosts
echo '127.0.0.1    website2.com' | sudo tee -a /etc/hosts
sudo nginx -s reload

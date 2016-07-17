# Docker - Nginx Reverse Proxy

# Use Case:
This installation script is intended to configure a server to host multiple websites. This script has only been tested on Ubuntu 14.04, but should work on most version of Ubuntu, or Linux distros that support apt-get.

# How it works:
Todo

# Installation: 
## Configure docker-compose.yml
```sh
website1:
  #UNCOMMENT IN CASE THE CONTAINER EVER NEEDS TO BE CUSTOMIZED
  #build: ./website1
  image: nickistre/ubuntu-lamp
  ports:
    - "4327:80"
```
**Optional**: Replace the names of the Docker image 'website1' with the name of your website.
**Optional**: Change the Docker image to pull. Other Docker images can be found on DockerHub. The default on this installation script is a LAMP stack.  
**Optional**: Replace the port '4327' with a custom port. The format is host_port : docker_port, so don't change the Docker port from 80 without good reason, otherwise the website will not load.

## Configure Docker_setup.sh
```sh
echo '127.0.0.1    website1.com' | sudo tee -a /etc/hosts
echo '127.0.0.1    website2.com' | sudo tee -a /etc/hosts
```
These two lines add domain names to your host file.

**Optional**: Replace the names of the domain name 'website1.com' with your domain name. Don't own a domain name? That's alright, you'll still be able to access the Docker container locally using whatever domain name in place in this file.

## Configure nginx_config
```sh
server {
    listen       80;
    server_name  website1.com;

    location / {
        proxy_pass http://127.0.0.1:4327;
    }
}
```
This is the reverse proxy configuration used by Nginx to access your Docker containers based on the web address Nginx receives.

**Optional**: Replace the names of the domain name 'website1.com' with your domain name. Make sure this matches the name you put in Docker_setup.sh    
**Optional**: Replace the port '4327' with your custom port. Make sure this matches the Docker port you put in docker-compose.yml

## Run Docker_setup.sh
```sh
./Docker_setup.sh
```
Once the script has finished, all containers in your docker-composer.yml file should be running. You can confirm this by using 'website1.com' (or whatever domain names you gave your Docker containers) into a web browser. You should see an Apache information page.

## Connect to a container to edit source code
**Note**: If you receive an error with any of these commands, run them with sudo

```sh
docker ps
```

You will see a list of the running containers. Copy the CONTAINER ID (ie **49498ec40361**) and run the following command to enter the container.
```sh
docker exec -it 49498ec40361 bash
```
Using the default container 'nickistre/ubuntu-lamp', the source code for the website's homepage will be located at
```sh
/var/www/html
```

# TODO:
 - Add volumes to composer script, allowing source code to live outside of the container
 - Skip Docker installation if Docker is already installed
 - Set flag to delete all Docker images/containers
 - Set flag to reset host file

#!/bin/bash

# Author: Ankit Raut 

# Description: 

setVariables()
{
    #defining directory path.
    # path="/home/ubuntu/Node-Project"
    path="/home/ankitraut0987/shopping-project"
    
    #defining nginx path
    nginx_path="/etc/nginx/sites-enabled"

}

getVariables()
{
    echo "Path:$path"
    echo "Nginx Path:$nginx_path"

}


setVariables

#Install Nginx Server
sudo apt-get install nginx -y >/dev/null || { echo "Failed to Install Nginx Server"; exit 1; }

#Configuring Nginx Server:
sudo rm "$nginx_path/default" || echo "Default Config File Not Found"
cd "$path/Execution-Script/"
sudo cp "default" "$nginx_path/"
sudo systemctl restart nginx

echo "*** Successfully Configured Nginx ***"

cd

sudo apt-get install docker -y >/dev/null && echo "** Successfully Installed Docker **" || { echo "Failed to Install Docker"; exit 1; }
sudo apt-get install docker-compose -y >/dev/null && echo "** Successfully Installed Docker-Compose **" || { echo "Failed to Install Docker-Copmose"; exit 1; }


cd "$path"


# Stop and remove containers, including volumes, if they are running
if [ ! -z "shopping-project_frontend_1" ] || [ ! -z "shopping-project_backend_1" ]; then
    sudo docker-compose down --volumes
fi

# Remove frontend and backend images, if they exist
if [ ! -z "shopping-project_frontend" ]; then
    sudo docker rmi -f shopping-project_frontend
fi

if [ ! -z "shopping-project_backend" ]; then
    sudo docker rmi -f shopping-project_backend
fi

# Check if containers and images are removed, then rebuild them
if [ -z "$(sudo docker ps -q -f name=frontend)" ] && [ -z "$(sudo docker ps -q -f name=backend)" ] && \
   [ -z "$(sudo docker images -q frontend_image)" ] && [ -z "$(sudo docker images -q backend_image)" ]; then
    sudo docker-compose up -d
else
    echo "Error: Containers or images still exist. Manual intervention may be required."
fi

sudo docker-compose up -d || echo "error in compose file"


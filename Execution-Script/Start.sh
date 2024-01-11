#!/bin/bash

# Author: Dipali Dhanwade
# Author: Ankit Raut

# Description: 

setVariables()
{
    #defining directory path.
    # path="/home/ubuntu/Node-Project"
    path="/home/dipali_dhanwade/shopping-app"
    
    #defining nginx path
    nginx_path="/etc/nginx/sites-enabled"

}

getVariables()
{
    echo "Path:$path"
    echo "Nginx Path:$nginx_path"

}


setVariables

sudo apt-get update
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


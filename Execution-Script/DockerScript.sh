#!/bin/bash

# Author: Ankit Raut 

# Description: 

setVariables()
{
    #defining directory path.
    # path="/home/ubuntu/Node-Project"
    path="/home/dipali_dhanwade/shopping-project"
    
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
                                                                                                                            
sudo docker-compose down && echo "Docker Is Down Now" || echo "Docker Already Down"

#sudo docker rm shopping-project_frontend_1
#sudo docker rm shopping-project_backend_1

sudo docker rmi shopping-project_frontend || echo "Error deleting frontend image"
sudo docker rmi shopping-project_backend || echo "Error deleting backend image"

cd "$path"
sudo docker-compose up -d || echo "error in compose file"



#-----------------------------------------------------------------------------------------------------------------------------------------

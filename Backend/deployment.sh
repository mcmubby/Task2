#!/bin/bash
##Deployment on fresh Ubuntu 16.04 Server

##This part is done manually via (I will probably find a way around this later)
##Download source code from repository
##sudo wget https://github.com/{GITHUB_USERNAME}/{REPOSITORY_NAME}/archive/{BRANCH}/{REPOSITORY_NAME}.zip
##sudo wget https://github.com/mcmubby/Task2/archive/main/Task2.zip

##Install Unzip
##sudo apt install unzip

##Unzip downloaded repo
##sudo unzip {REPOSITORY_NAME}.zip
##This will be unzipped to {REPOSITORY_NAME}-{BRANCH} folder
##sudo unzip Task2.zip

##Add Microsoft to package repository
wget https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

##Install .NET SDK (currently using .NET5.0)
echo "###Installing dotnet sdk 5.0"
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-5.0

##Or install the .NET Runtime only
##sudo apt-get update; \
##  sudo apt-get install -y apt-transport-https && \
##  sudo apt-get update && \
##  sudo apt-get install -y aspnetcore-runtime-5.0


##Install Nginx
echo "###Installing Nginx"
sudo apt-get install -y nginx
sudo service nginx start

##Backup site-available/default
echo "###Configuring Nginx"
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

##Copy default from repository folder
sudo cp Task2-main/Backend/default /etc/nginx/sites-available/default

##Test nginx configuration and reload service
sudo nginx -t
sudo nginx -s reload

##Publish application
echo "###Restoring and Publishing application"
cd Task2-main/Backend/Resume
sudo dotnet restore
sudo dotnet publish -c Release -o resumeapp

##copy published app (not necessary)
sudo cp -r ~/Task2-main/Backend/Resume/resumeapp /var/www/

##copy service file for application
echo "###Configuration of Application Service"
sudo cp ~/Task2-main/Backend/resumeapp.service /etc/systemd/system/resumeapp.service

##Enable and start service
echo "###Enabling and Starting App Service"
sudo systemctl enable resumeapp.service
sudo systemctl start resumeapp.service
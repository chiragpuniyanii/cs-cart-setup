#!/bin/bash

# Update system
sudo apt update

# Install Apache2 and PHP dependencies
sudo apt install apache2 php libapache2-mod-php php-mysql php-curl php-zip php-gd php-mbstring php-xml php-cli php-intl -y

# Install unzip (if not installed)
sudo apt install unzip -y

# Install MySQL
sudo apt install mysql-server -y

# Install SOAP extension
sudo apt install php8.2-soap -y

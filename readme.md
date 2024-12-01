# CS-Cart Multi-Vendor Setup on Linux (EC2 Instance)

This repository contains the detailed steps and configuration required to install CS-Cart Multi-Vendor on an EC2 instance running Ubuntu. The setup includes installing Apache, PHP, MySQL, and all necessary dependencies.

## Prerequisites
Before starting, ensure you have the following:
- A **CS-Cart Multi-Vendor Zip** file (e.g., `multivendor_v4.18.2.SP1.zip`)
- **Amazon EC2** instance with **Ubuntu** installed
- **SSH key** to access the EC2 instance
- **Domain** or public IP address for your EC2 instance

## Steps for Setup

### Step 1: Download CS-Cart Multi-Vendor Zip
1. Go to [CS-Cart's website](https://www.cs-cart.com/) and download the **CS-Cart Multi-Vendor version**.
2. Save the file (e.g., `multivendor_v4.18.2.SP1.zip`) to your local machine.

### Step 2: Transfer Zip File from Local Machine to EC2 Instance
1. Open **PowerShell** or **Git Bash** on your Windows machine.
2. Use the following command to transfer the zip file to your EC2 instance:
   ```bash
   scp -i "C:\Users\AS\Downloads\secret_key.pem" "C:\Users\AS\Downloads\multivendor_v4.18.2.SP1.zip" ubuntu@13.229.81.83:/home/ubuntu/

### Step 3: Install Dependencies ###
   **SSH into your EC2 instance and run the following commands to install Apache, PHP, and necessary PHP extensions.**

      sudo apt update
      sudo apt install apache2 -y
      sudo apt install php libapache2-mod-php php-mysql php-curl php-zip php-gd php-mbstring php-xml php-cli php-intl unzip -y
   
### Step 4: Unzip the CS-Cart Zip File ###

   **Install unzip (if not already installed):**


      sudo apt install unzip -y
   Navigate to the html directory:


      cd /var/www/html/
   Unzip the CS-Cart Multi-Vendor zip file:

      sudo unzip /home/ubuntu/multivendor_v4.18.2.SP1.zip

### Step 5: Move Files to the CS-Cart Folder ###
   **Create a folder for CS-Cart:**


      sudo mkdir cscart
   Move the extracted files to the cscart folder:


      sudo mv multivendor_v4.18.2.SP1/* cscart/

### Step 6: Set Permissions for CS-Cart Files ###
   **Set the appropriate file permissions and ownership for the cscart folder:**


      sudo chown -R www-data:www-data /var/www/html/cscart
      sudo chmod -R 755 /var/www/html/cscart
### Step 7: Configure Apache for CS-Cart ###
   **Create a configuration file for CS-Cart:**


      sudo vi /etc/apache2/sites-available/cscart.conf
   **Add the following configuration:**


      <VirtualHost *:80>
          ServerAdmin admin@yourdomain.com
          DocumentRoot /var/www/html/cscart
          ServerName http://your_ec2_public_ip/
      
          <Directory /var/www/html/cscart>
              Options Indexes FollowSymLinks
              AllowOverride All
              Require all granted
          </Directory>
      
          ErrorLog ${APACHE_LOG_DIR}/error.log
          CustomLog ${APACHE_LOG_DIR}/access.log combined
      </VirtualHost>

### Step 8: Enable Site, Disable Default Site, and Restart Apache ###

   **Enable the CS-Cart site:**

```
sudo a2ensite cscart.conf
```
Disable the default Apache site:
   ```   
sudo a2dissite 000-default.conf
```
 Restart Apache to apply the changes:   
 ```  
sudo systemctl restart apache2
   ```
### Step 9: Install MySQL and Create Database ###
   **Install MySQL Server:**


      sudo apt install mysql-server -y
   ##Log in to MySQL and configure it:
```bash
      sudo mysql
```
```sql
      ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'chirag';
      CREATE DATABASE cscart_db;
      CREATE USER 'cscart_user'@'localhost' IDENTIFIED BY 'your_password';
      GRANT ALL PRIVILEGES ON cscart_db.* TO 'cscart_user'@'localhost';
      FLUSH PRIVILEGES;
      EXIT;
```
### Step 10: Install PHP SOAP Extension ###

   **Install the SOAP extension for PHP:**


      sudo apt install php8.2-soap -y
      sudo systemctl restart apache2

### Step 11: Access CS-Cart ###

   **Open your browser and navigate to your EC2 instance's public IP address (e.g., http://your_ec2_public_ip/). You should see the CS-Cart installation page.**

   Follow the installation steps on the web interface:

      Database Name: cscart_db
      Database User: cscart_user
      Password: chirag
      Complete the installation by following the web-based wizard.

### Step 12: Final Setup for Multi-Vendor ###
   After the installation is complete:

   Log in to the Admin Panel at http://your_ec2_public_ip/admin.php.
   Configure your store settings, payment methods, shipping options, and other store configurations.
   To enable the Multi-Vendor functionality, configure the necessary settings from the admin panel.

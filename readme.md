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
   scp -i "C:\path\to\your\secret_key.pem" "C:\path\to\your\multivendor_v4.18.2.SP1.zip" ubuntu@<your-ec2-public-ip>:/home/ubuntu/


Step 3: SSH into EC2 Instance
SSH into your EC2 instance:
bash
Copy code
ssh -i "path/to/your/secret_key.pem" ubuntu@<your-ec2-public-ip>
Step 4: Install Apache, PHP, and Required Extensions
Update the package list and install Apache:

bash
Copy code
sudo apt update
sudo apt install apache2 -y
Install PHP and the necessary PHP extensions for CS-Cart:

bash
Copy code
sudo apt install php libapache2-mod-php php-mysql php-curl php-zip php-gd php-mbstring php-xml php-cli php-intl -y
Step 5: Unzip CS-Cart Files
Install unzip utility (if not installed):

bash
Copy code
sudo apt install unzip -y
Navigate to the Apache web directory:

bash
Copy code
cd /var/www/html/
Unzip the CS-Cart zip file:

bash
Copy code
sudo unzip /home/ubuntu/multivendor_v4.18.2.SP1.zip
Step 6: Organize CS-Cart Files
Create a new directory for CS-Cart:

bash
Copy code
sudo mkdir cscart
Move the unzipped CS-Cart files to the newly created folder:

bash
Copy code
sudo mv multivendor_v4.18.2.SP1 cscart
Step 7: Set Permissions for CS-Cart Files
Set the appropriate ownership for the CS-Cart folder:

bash
Copy code
sudo chown -R www-data:www-data /var/www/html/cscart
Set permissions for the CS-Cart files:

bash
Copy code
sudo chmod -R 755 /var/www/html/cscart
Step 8: Configure Apache for CS-Cart
Create a new Apache virtual host configuration file:

bash
Copy code
sudo vi /etc/apache2/sites-available/cscart.conf
Add the following configuration to the cscart.conf file:

apache
Copy code
<VirtualHost *:80>
    ServerAdmin admin@yourdomain.com
    DocumentRoot /var/www/html/cscart
    ServerName <your-server-ip-or-domain>

    <Directory /var/www/html/cscart>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
Replace <your-server-ip-or-domain> with your EC2 server's public IP or your domain name.

Step 9: Enable Apache Site and Restart Apache
Enable the new site and disable the default site:

bash
Copy code
sudo a2ensite cscart.conf
sudo a2dissite 000-default.conf
Restart Apache to apply the changes:

bash
Copy code
sudo systemctl restart apache2
Step 10: Install MySQL and Configure Database
Install MySQL server:

bash
Copy code
sudo apt install mysql-server -y
Access MySQL shell:

bash
Copy code
sudo mysql
Create a database and user for CS-Cart:

sql
Copy code
CREATE DATABASE cscart_db;
CREATE USER 'cscart_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON cscart_db.* TO 'cscart_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
Replace your_password with a secure password.

Step 11: Install SOAP Extension for PHP
Install PHP SOAP extension:

bash
Copy code
sudo apt install php8.2-soap -y
Restart Apache to enable the SOAP extension:

bash
Copy code
sudo systemctl restart apache2
Step 12: Run the CS-Cart Setup
Navigate to the CS-Cart installation URL in your web browser:
If you are using the public IP of your EC2 instance, access it like http://<your-ec2-public-ip>/
Follow the CS-Cart installation wizard to complete the setup.
Conclusion
You have now successfully installed and configured CS-Cart on your EC2 instance running Ubuntu. Make sure to follow the installation wizard in the web browser to finish setting up the store.

yaml
Copy code

---

### How to Use the `README.md`:
1. Create a `README.md` file in your project folder:
   ```bash
   touch README.md
Open it and paste the content from above. You can edit it with any text editor (e.g., vi, nano, or use any GUI editor on your local machine).

Follow the GitHub steps to push your project with this README.md file.


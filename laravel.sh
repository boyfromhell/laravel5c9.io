# Clear existing files
#
rm hello-world.php php.ini README.md

# Install and configure PHP 7.2 Ondrej Repository
#
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install libapache2-mod-php7.2 -y
sudo a2dismod php5
sudo a2enmod php7.2
sudo apt-get install php7.2-curl php7.2-cli php7.2-dev php7.2-gd php7.2-intl php7.2-mcrypt php7.2-json php7.2-mysql php7.2-opcache php7.2-bcmath php7.2-mbstring php7.2-soap php7.2-xml php7.2-zip -y

#Install Laravel
#
sudo composer global require 'laravel/installer'
export PATH=~/.composer/vendor/bin:$PATH
sudo chown -R $USER $HOME/.composer
laravel new 
rm -rf ./composer

#Configure public folder
#
printf '%s\n' ':%s/DocumentRoot\ \/home\/ubuntu\/workspace/DocumentRoot\ \/home\/ubuntu\/workspace\/public/g' 'x'  | sudo ex /etc/apache2/sites-enabled/001-cloud9.conf

#Select and install the mysql version 5.7 or up
#
wget https://dev.mysql.com/get/mysql-apt-config_0.8.9-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.9-1_all.deb
sudo service apache2 restart
sudo apt-get update
sudo apt-get install mysql-server -y 
sudo service  mysql restart 
sudo mysql_upgrade

#Configure database and .env file database=laravel, user=root, no password
#
sudo mysql --user="root" -e "CREATE DATABASE laravel character set UTF8mb4 collate utf8mb4_bin;"
printf '%s\n' ':%s/DB_DATABASE=homestead/DB_DATABASE=laravel/g' 'x'  | sudo ex .env
printf '%s\n' ':%s/DB_USERNAME=homestead/DB_USERNAME=root/g' 'x'  | sudo ex .env
printf '%s\n' ':%s/DB_PASSWORD=secret/DB_PASSWORD=/g' 'x'  | sudo ex .env

#Artisan auth scaffolding and migration
#
php artisan preset bootstrap
php artisan make:auth
php artisan migrate:fresh

# setup npm and nodejs for web mixing
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#sudo apt-get install -y nodejs
#sudo npm install
#sudo npm rebuild node-sass

#remove laravel installer
#
rm -rf laravel.sh
rm -rf mysql-apt-config_0.8.9-1_all.deb

echo "Running initial scripts"

echo " "
if [ "$EUID" -ne 0 ]
	then echo "Please run this script using sudo! 'sudo ./op-run.sh'"
	exit
fi

echo "Get updates ......."
sudo apt update
echo "Upgrade installs ......."
sudo apt upgrade
echo "Upgrades complete!"
echo " "
echo "Installing snap ......."
sudo apt install snapd
sudo snap install core; sudo snap refresh core
echo "Done!"
echo " "
echo "Installing certbot ......."
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo "Done! (Use 'sudo certbot --apache' later to create certificate)"
echo " "
echo "Installing PHP dependancies ......."
sudo apt install php7.4-imagick
sudo apt install php7.4-zip
echo "Done!"
echo " "
echo "Installing apache dependancies ......."
sudo a2dismod expires
sudo a2enmod ssl
sudo a2enmod http2
sudo a2dismod mpm_prefork
sudo a2enmod mpm_event

sudo sudo /etc/init.d/apache2 restart
echo "Done and dusted! Check notes in this script to see what is next."

echo "List of things to do"
echo " "
echo "# Add user to group and change permissions for FTP"
echo "# sudo adduser nathan www-data"
echo "# sudo chown -R www-data:www-data /var/www"
echo "# sudo chmod -R g+rwX /var/www"
echo " "
echo "# HTTP 2"
echo "# nano /etc/apache2/sites-available/000-default-le-ssl.conf"
echo "# Add line under <Virtual host ...."
echo "# Protocols h2 h2c http/1.1"

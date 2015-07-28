sudo apt-get clean
sudo apt-get update && sudo apt-get upgrade
apt-get install -y apache2-utils apache2 rake
locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8
dpkg-reconfigure locales
sudo gem install jekyll
cd /blog/
nohup jekyll serve --host 0.0.0.0 -w&

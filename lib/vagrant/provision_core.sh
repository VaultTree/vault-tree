# A Simple Vagrant Provisioning Script 
# Just the basics:
# Git and Ruby 1.9.3

# Update Package Index for apt-get
sudo apt-get --yes update

# Get Git
sudo apt-get --yes install git

# Need to install make. Ubuntu servers do not have it by default.
sudo apt-get install make

# Need to install unzip
sudo apt-get --yes install unzip

# Need to install curl
sudo apt-get --yes install curl

# Need to install g++ to compile therubyracer
sudo apt-get --yes install g++

exit

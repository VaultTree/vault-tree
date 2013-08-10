#!/usr/bin/env bash

: <<DOCUMENTATION
  chruby (https://github.com/postmodern/chruby) - "Changes the current Ruby"
    Shell script that adds a given version of Ruby onto the path.

DOCUMENTATION

# store the version of programs to download
ruby_version="1.9.3-p374"
chruby_version="0.3.5"

# store the present directory
cur_dir=$(pwd)

# create the /home/vagrant/.rubies directory and switch to it
mkdir -v /home/vagrant/.rubies
cd /home/vagrant/.rubies

# create a hidden directory for ruby-build
mkdir -v .ruby-build
cd .ruby-build

# pull ruby-build from github
git clone https://github.com/sstephenson/ruby-build.git .
sudo ./install.sh

# download the correct version of Ruby using ruby-build
ruby-build "$ruby_version" "/home/vagrant/.rubies/$ruby_version"

# exit the jruby directory and go to .rubies
cd /home/vagrant/.rubies

# create a hidden directory for the chruby installation
mkdir -v .chruby
cd .chruby

# install chruby
# from: https://github.com/postmodern/chruby#install
curl -O -L \
"https://github.com/postmodern/chruby/archive/v$chruby_version.tar.gz"
tar xzvf "v$chruby_version.tar.gz"
cd "chruby-$chruby_version"
make install

# add the script to their .bashrc so it is used all the time
echo "source /usr/local/share/chruby/chruby.sh" >> /home/vagrant/.bashrc

# Use chruby to switch to JRUBY
echo "chruby $ruby_version" >> /home/vagrant/.bashrc

# source the script in the current session
source /usr/local/share/chruby/chruby.sh


cd $cur_dir

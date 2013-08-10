touch /home/vagrant/project_postinstall.sh
project_postinstall='/home/vagrant/project_postinstall.sh'

# Ensure that the correct gem is used for installation
echo 'source /usr/local/share/chruby/chruby.sh' >> $project_postinstall
echo 'source /home/vagrant/.bashrc' >> $project_postinstall
echo 'chruby 1.9.3-p374' >> $project_postinstall

# Use sudo because bundler will be a system-wide gem
echo 'gem install bundler' >> $project_postinstall
echo 'cd /vagrant' >> $project_postinstall

# sudo not used since bundle will know where to install per-user
echo 'bundle' >> $project_postinstall

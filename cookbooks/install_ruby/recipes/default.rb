require_recipe 'git'
version = '0.3'

execute "build ruby 1.9.3" do
  command "ruby-build 1.9.3-p448 '/home/vagrant/.rubies/1.9.3-p448'"
  user "root"
  cwd "/home/vagrant"
end

execute "add chruby to bashrc" do
  command "echo 'chruby 1.9.3-p448' >> /home/vagrant/.bashrc"
  user "vagrant"
  cwd "/home/vagrant"
end

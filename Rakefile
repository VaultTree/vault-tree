# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'rake'

namespace :build do
  desc 'Manual Install of Brew Package'
  task :homebrew do
    puts "Manual Homebrew Install"
    path = '/usr/local/Cellar/vault-tree'
    require 'fileutils'
    puts "Removing Existing Directory"
    FileUtils.rm_rf path
    puts "Createing a new dir"
    target = Dir::mkdir(path)
    version_dir = "#{path}/0.0.1"
    Dir::mkdir(version_dir)
    vault_tree_dir = Dir.pwd
    puts "Copying all files from #{vault_tree_dir} over to #{version_dir}"
    FileUtils.cp_r(Dir["#{vault_tree_dir}/*"], version_dir)
  end 
end

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

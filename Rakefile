require_relative 'config/initialize'
require 'rake'
require 'bundler'
require 'bundler/setup'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

namespace :db do
  def database 
    VaultTree::DataBase.new
  end

  desc "Migrate the db"
  task :migrate do
    database.migrate
  end

  desc "Create the db"
  task :create do
    database.create
  end

  desc "drop the db"
  task :drop do
    database.drop
  end

  desc "setup the db"
  task :setup do
    database.setup 
  end
end

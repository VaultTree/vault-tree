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


require "rubygems"
require "bundler/setup"
require 'active_record'
require 'yaml'

namespace :db do

  desc "Migrate the db"
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc "Create the db"
  task :create do
    project_root = File.dirname(File.absolute_path(__FILE__))
    Dir.glob(project_root + "/app/models/*.rb").each{|f| require f}

    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)

    if __FILE__ == $0
      puts "Count of Pages: #{Page.count}"
    end

    ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
  end

  desc "drop the db"
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    admin_connection = connection_details.merge({'database'=> 'postgres', 
                                                'schema_search_path'=> 'public'}) 
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
  end
end

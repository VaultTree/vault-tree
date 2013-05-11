# encoding: utf-8
require 'rubygems'
require 'rake'
require 'bundler'
require "bundler/setup"
require 'sqlite3'
require 'active_record'
require 'yaml'


begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

namespace :db do

  def active_record_models
    project_root = File.dirname(File.absolute_path(__FILE__))
    Dir.glob(project_root + "/app/models/*.rb").each{|f| require f}
  end

  module VaultTree
    class PathHelpers
      def self.project_dir
        File.dirname(File.absolute_path(__FILE__))
      end
    end
  end

  module VaultTree
    class DataBase
      attr_reader :config_file

      def initialize
        @config_file = "#{project_dir}/config/database.yml"
      end

      def create
        SQLite3::Database.new(connection_details["database"])
      end

      def drop
        begin
          FileUtils.rm(connection_details["database"])
        rescue
          nil
        end
      end
      
      def migrate
        establish_connection
        ActiveRecord::Migrator.migrate("db/migrate/")
      end

      def setup
        drop
        create
        migrate
      end

      private

      def project_dir
        VaultTree::PathHelpers.project_dir
      end

      def connection_details
        YAML::load_file(config_file)
      end

      def establish_connection
        puts connection_details
        ActiveRecord::Base.establish_connection(connection_details)
      end
    end
  end

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

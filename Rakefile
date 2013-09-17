require_relative 'config/initialize'
require 'rake'
require 'bundler'
require 'bundler/setup'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end


desc "Run Tests"
task :test do
  puts 'Run tests with rspec and cucumber'
end

task :default => :test

# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'rake'

namespace :build do
  desc 'Manual Install of Brew Package'
  task :homebrew do
    puts "Manual Homebrew Install"
  end
end

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

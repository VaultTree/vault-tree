require_relative 'lib/vault-tree.rb'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

task :default => 'spec'

Cucumber::Rake::Task.new('cuke') do |t|
  # -r means you require all support files first
  # this allows you to organize and run by subdirectory
  t.cucumber_opts = "-r features features --format pretty"
end

task :spec => 'cuke' do
  STDOUT.write %x[rspec --format doc]
end

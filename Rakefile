require_relative 'lib/vault-tree.rb'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

task :default do
  Rake::Task["cuke"].invoke
  Rake::Task["contracts"].invoke
  Rake::Task["spec"].invoke
end

Cucumber::Rake::Task.new(:cuke) do |t|
  # -r means you require all support files first
  # this allows you to organize and run by subdirectory
  t.cucumber_opts = "-r features features --format pretty"
end

Cucumber::Rake::Task.new(:contracts) do |t|
  # -r means you require all support files first
  # this allows you to organize and run by subdirectory
  t.cucumber_opts = "-r features features/contracts --format pretty"
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "--format doc"
end

desc 'Upload Features and Markdown to Relish'
task :relish do
  puts `relish push vault-tree/vault-tree`
end

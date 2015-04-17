require_relative 'lib/vault-tree.rb'
require 'cucumber'
require 'cucumber/rake/task'
require "bundler/gem_tasks"

task :default do
  Rake::Task["test"].invoke
  Rake::Task["cuke"].invoke
  Rake::Task["contracts"].invoke
end

Cucumber::Rake::Task.new(:cuke) do |t|
  # -r means you require all support files first
  # this allows you to organize and run by subdirectory
  t.cucumber_opts = "-r features features --format pretty"
end

# run a particuar scenario
# cucumber -r features features/contracts --format pretty features/keywords/external_input.feature
Cucumber::Rake::Task.new(:contracts) do |t|
  # -r means you require all support files first
  # this allows you to organize and run by subdirectory
  t.cucumber_opts = "-r features features/contracts --format pretty"
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb']
end

desc 'Upload Features and Markdown to Relish'
task :relish do
  puts `relish push vault-tree/vault-tree`
end

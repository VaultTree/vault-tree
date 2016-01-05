require_relative 'lib/vault-tree.rb'
require "bundler/gem_tasks"

task :default do
  Rake::Task["test"].invoke
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb','spec/vault_collections/*_spec.rb']
end

desc 'Upload Features and Markdown to Relish'
task :relish do
  puts `relish push vault-tree/vault-tree`
end

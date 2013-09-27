require_relative 'config/initialize'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

task :default => 'cuke:api'

Cucumber::Rake::Task.new('cuke:api') do |t|
  # -r means you require all support files first
  # this allows you to organize and run by subdirectory
  t.cucumber_opts = "-r features features/api --format pretty"
end

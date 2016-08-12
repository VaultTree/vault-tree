require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb','spec/vault_collections/*_spec.rb']
end

task :default do
  Rake::Task["test"].invoke
end

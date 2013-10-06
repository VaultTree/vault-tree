# -*- encoding: utf-8 -*-
# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','vault-tree','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'vault-tree'
  s.version = VaultTree::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = 'A DSL for building distributed cryptographic contracts'
  s.description = 'Vault Tree as a collection of tools that helps web developers, businesses, and online communities explore a new way of thinking about contracts.'
  s.required_ruby_version = '>= 1.9.3'
  s.required_rubygems_version = '>= 1.8.11'

  s.author = 'Andy Bashelor'
  s.email = 'abash1212@gmail.com'
  s.homepage = 'http://vault-tree.org'
  s.license = 'MIT'

  s.files = Dir[ 'config/**/*', 'app/**/*', 'lib/**/*']
  s.require_path = 'lib'

  s.add_dependency 'require_all', '~> 1.2.1'
  s.add_dependency 'rbnacl', '~> 1.1.0'
  s.add_dependency 'activesupport', '~> 3.2.13'
  s.add_dependency 'base32', '~> 0.2.0'
  s.add_dependency 'rainbow', '~> 1.1.4'
  s.add_dependency 'json', '>= 1.8.0'
  s.add_development_dependency 'rake', '>= 10.0.4'
  s.add_development_dependency 'cucumber', '~> 1.3.2'
  s.add_development_dependency 'rspec', '~> 2.13.0'
  s.add_development_dependency 'factory_girl_rails', '~> 4.2.1'
end

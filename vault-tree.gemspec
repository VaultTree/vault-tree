# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vault-tree/version'

Gem::Specification.new do |spec|
  spec.name          = "vault-tree"
  spec.version       = VaultTree::VERSION
  spec.authors       = ["Andy Bashelor"]
  spec.email         = ["abash1212@gmail.com"]
  spec.description   = %q{Vault Tree is a Ruby library for executing distributed cryptographic contracts.}
  spec.summary       = %q{The Self Enforcing Contract}
  spec.homepage      = "http://vaulttree.github.io/"
  spec.license       = "MIT"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rbnacl-libsodium"
  spec.add_dependency "json-schema"
  spec.add_development_dependency "rake"
end

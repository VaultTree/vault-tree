# Dependencies
require 'json'
require 'rbnacl'
require 'secretsharing'

# *.rb
require_relative 'vault-tree/path_helpers'
require_relative 'vault-tree/version'

# util/*.rb
require_relative 'vault-tree/util/json'
require_relative 'vault-tree/util/string'

# exceptions/*.rb
require_relative 'vault-tree/exceptions/vault_tree_exception'
VaultTree::PathHelpers.exceptions_files.each {|file| require_relative  file }

# contract/*.rb
VaultTree::PathHelpers.contract_files.each {|file| require_relative  file }

# keywords/*.rb
require_relative 'vault-tree/keywords/keyword'
VaultTree::PathHelpers.keywords_files.each {|file| require_relative  file }

# lock_smith/*.rb
VaultTree::PathHelpers.lock_smith_files.each {|file| require_relative  file }

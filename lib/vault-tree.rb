# *.rb
require_relative 'vault-tree/path_helpers'
require_relative 'vault-tree/version'

# config/*.rb
require_relative 'vault-tree/config/dependencies'
require_relative 'vault-tree/config/string'

# util/*.rb
require_relative 'vault-tree/util/json'

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

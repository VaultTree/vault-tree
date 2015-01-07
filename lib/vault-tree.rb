# *.rb
require_relative 'vault-tree/path_helpers'
require_relative 'vault-tree/version'

# util/*.rb
require_relative 'vault-tree/util/json'
require_relative 'vault-tree/util/string'

# lock_smith.rb
require_relative 'vault-tree/lock_smith'

# notifications/*.rb
require_relative 'vault-tree/notifications/notification'
VaultTree::PathHelpers.notification_files.each {|file| require_relative  file }

# contract/*.rb
VaultTree::PathHelpers.contract_files.each {|file| require_relative  file }

# keywords/*.rb
require_relative 'vault-tree/keywords/keyword'
VaultTree::PathHelpers.keywords_files.each {|file| require_relative  file }

# lock_smith/*.rb
VaultTree::PathHelpers.lock_smith_files.each {|file| require_relative  file }

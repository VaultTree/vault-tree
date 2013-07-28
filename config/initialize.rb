# require_relative - Ruby > 1.9 method
# require_rel - 'gem require_all' helper method

require_relative 'initializers/dependencies'
require_relative 'initializers/path_helpers'
require_relative 'initializers/version'
require_relative 'initializers/database'
require_relative 'initializers/app'
require_relative 'initializers/lib'
require_rel 'initializers/monkey_patches'

# connect to the database
VaultTree::DataBase.new.establish_connection

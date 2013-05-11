module VaultTree
  class DataBase
    attr_reader :config_file

    def initialize
      @config_file = PathHelpers.database_config
    end

    def create
      SQLite3::Database.new(connection_details["database"])
    end

    def drop
      begin
        FileUtils.rm(connection_details["database"])
      rescue
        nil
      end
    end
    
    def migrate
      establish_connection
      ActiveRecord::Migrator.migrate("db/migrate/")
    end

    def setup
      drop
      create
      migrate
    end

    def establish_connection
      ActiveRecord::Base.establish_connection(connection_details)
    end

    private

    def project_dir
      VaultTree::PathHelpers.project_dir
    end

    def connection_details
      YAML::load_file(config_file)
    end
  end
end

#VaultTree::DataBase.new.establish_connection

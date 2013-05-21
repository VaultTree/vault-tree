module VaultTree
  class PathHelpers

    def self.current_dir
      File.dirname(__FILE__)
    end 

    def self.walk_to_root
      '../../'
    end 

    def self.project_dir
      File.expand_path(project_dir_rel)
    end

    def self.project_dir_rel
      File.join(current_dir,walk_to_root)
    end

    def self.app_dir
     "#{project_dir}/app"
    end

    def self.lib_dir
     "#{project_dir}/lib"
    end

    def self.database_config
     "#{project_dir}/config/database.yml"
    end

    def self.factories
     "#{project_dir}/spec/factories"
    end

    def self.spec_helper
     "#{project_dir}/spec/spec_helper"
    end

    def self.practice_config_dir
     "#{project_dir}/.vault-tree"
    end

    def self.config_dir
     "#{project_dir}/.vault-tree"
    end

    def self.contracts_dir
     "#{project_dir}/.vault-tree/contracts"
    end

  end
end

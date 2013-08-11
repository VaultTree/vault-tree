module VaultTree
  module PathHelpers
    extend self

    def current_dir
      File.dirname(__FILE__)
    end 

    def walk_to_root
      '../../'
    end 

    def project_dir
      File.expand_path(project_dir_rel)
    end

    def project_dir_rel
      File.join(current_dir,walk_to_root)
    end

    def app_dir
     "#{project_dir}/app"
    end

    def lib_dir
     "#{project_dir}/lib"
    end

    def database_config
     "#{project_dir}/config/database.yml"
    end

    def factories
     "#{project_dir}/spec/factories"
    end

    def practice_config_dir
     "#{project_dir}/.vault-tree"
    end

    def one_two_three_030
      "#{project_dir}/spec/support/fixtures/one_two_three-0.3.0.EXP.json"
    end

    def one_two_three_050
      "#{project_dir}/spec/support/fixtures/one_two_three-0.5.0.EXP.json"
    end
  end
end

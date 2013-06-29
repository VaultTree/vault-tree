module VaultTree
  module PathHelpers
    extend self

    def current_dir
      File.dirname(__FILE__)
    end 

    def up_one
      '../'
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

    def spec_helper
     "#{project_dir}/spec/spec_helper"
    end

    def fixtures_dir
      "#{project_dir}/spec/support/fixtures"
    end

    def mal_formed_json_contract
     "#{fixtures_dir}/malformed_json_contract.json"
    end

    def practice_config_dir
     "#{project_dir}/.vault-tree"
    end

    def config_dir
     "#{project_dir}/.vault-tree"
    end

    def contracts_dir
     "#{project_dir}/.vault-tree/contracts"
    end

    def project_dir_parent_rel
      File.join(project_dir,up_one)
    end

    def project_dir_parent
      File.expand_path(project_dir_parent_rel)
    end

    def one_two_three_contract
      "#{project_dir_parent}/lab/contracts/one_two_three-0.1.0.EXP.json"
    end

    def one_two_three_020
      "#{project_dir_parent}/contracts/lab/one_two_three-0.2.0.EXP.json"
    end
  end
end

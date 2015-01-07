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
      lib_dir
    end

    def lib_dir
     "#{project_dir}/lib"
    end

    def fixtures_dir
      "#{project_dir}/features/support/contract_fixtures"
    end

    def reference_contract
      "#{fixtures_dir}/reference_contract.1.0.0.json"
    end

    def shared_secret_contract
      "#{fixtures_dir}/shared_secret_contract.json"
    end

    def broken_contract
      "#{fixtures_dir}/broken_contract.json"
    end

    def blank_simple_test_contract
      "#{fixtures_dir}/blank_simple_test_contract.json"
    end

    def simple_test_contract
      "#{fixtures_dir}/simple_test_contract.json"
    end

    def notification_files
      Dir["#{project_dir}/lib/vault-tree/notifications/*.rb"]
    end

    def keywords_files
      Dir["#{project_dir}/lib/vault-tree/keywords/*.rb"]
    end

    def lock_smith_files
      Dir["#{project_dir}/lib/vault-tree/lock_smith/*.rb"]
    end

    def contract_files
      Dir["#{project_dir}/lib/vault-tree/contract/*.rb"]
    end

    def core_contracts(file)
      "#{fixtures_dir}/#{file}"
    end
  end
end

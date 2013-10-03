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

    def factories
     "#{project_dir}/spec/factories"
    end

    def reference_contract
      "#{project_dir}/contracts/spec/reference.1.0.0.json"
    end

    def one_two_three
      "#{project_dir}/contracts/core/one_two_three.0.7.0.json"
    end

    def block_chain_key_transfer
      "#{project_dir}/contracts/core/block_chain_key_transfer.0.1.0.json"
    end

    def fixtures_dir
      "#{project_dir}/spec/support/fixtures"
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
  end
end

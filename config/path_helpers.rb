module VaultTree
  module PathHelpers
    extend self

    def current_dir
      File.dirname(__FILE__)
    end 

    def walk_to_root
      '../'
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

    def factories
     "#{project_dir}/spec/factories"
    end

    def fixtures_dir
      "#{project_dir}/spec/support/fixtures"
    end

    def reference_contract
      "#{fixtures_dir}/reference_contract.1.0.0.json"
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

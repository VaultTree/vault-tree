module VaultTree
  module ContractsRepo
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

      def lib_dir
       "#{project_dir}/lib"
      end

      def core_dir
       "#{project_dir}/core"
      end

      def core_contracts(file)
        "#{core_dir}/#{file}"
      end
    end
  end
end

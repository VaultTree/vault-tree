module VaultTree
  module CLI
    class Settings
      attr_reader :settings_file

      def initialize(settings_file)
        @settings_file = settings_file
      end

      def contents
        @contents = YAML.load_file(settings_file)
      end

      def save
        File.write(settings_file, to_yaml)
        true
      end

      def raw_contents
        File.read(settings_file)
      end

      def add_contract(name,path)
        new_contracts = contents[:contracts].merge({name => path})
        @contents = contents.merge(contracts: new_contracts) 
        save
        activate_if_only_contract(name)
      end

      def rm_contract(name)
        new_contract = contents[:contracts].delete_if {|key, value| key.to_s == name}
        @contents = contents.merge({:contracts => new_contract})
        save
      end

      def list_contracts
        contents[:contracts].keys
      end

      def activate_contract(name)
        @contents = contents.merge({active: name}) 
        save
      end

      def active_contract?(name)
        name == contents[:active]
      end

      def active_contract_path
        contents[:contracts][active_contract]
      end

      private

      def active_contract
        contents[:active]
      end

      def to_yaml
        @contents.to_yaml
      end

      def activate_if_only_contract(name)
        activate_contract(name) if contents[:contracts].keys.length == 1
        true
      end
    end
  end
end

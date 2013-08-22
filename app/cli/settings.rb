module VaultTree
  module CLI
    class Settings
      attr_reader :file_path

      def initialize(file_path)
        @file_path = file_path
      end

      def file_contents
        File.read(file_path)
      end

      def save(h)
        File.write(file_path, h.to_yaml)
      end

      def activate(name)
        puts name
        save contents.merge({active: name}) 
      end

      def contents
        YAML.load_file(file_path)
      end

      def contracts
        contents[:contracts]
      end

      def add_contract(name,path)
        new = contracts.merge({name => path})
        save contents.merge({:contracts => new})
      end

      def rm_contract(name)
        new_contract = contents[:contracts].delete_if {|key, value| key.to_s == name}
        save contents.merge({:contracts => new_contract})
      end

      def list_contracts
        if contents[:contracts] == {} || contents[:contracts] == nil
          return 'No Contracts Registered'
        else
          return contents[:contracts].keys
        end
      end

      def contract_path(name)
        contents[:contracts][name.to_s]
      end

      def no_contracts
        'No Contracts Registered'
      end

      def names_with_color
        names.map{|n| active_contract?(n) ? n.to_s.color(:green) : n.to_s}
      end

      def names
        contracts.keys
      end

      def show_file
      end

      def password
      end

      def data
      end

      def active_contract
        contents[:active]
      end

      def active_contract?(n)
        n == active_contract
      end

      def present
        SettingsPresenter.new(self).present
      end
    end
  end
end

module VaultTree
  module CLI
    class SettingsPresenter
    end
  end
end

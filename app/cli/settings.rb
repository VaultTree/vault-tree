module VaultTree
  module CLI
    class Settings
      attr_reader :file_path

      def initialize(file_path)
        @file_path = file_path
      end

      def password
      end

      def contracts
      end

      def data
      end

      def active_contract
      end

      def active_contract?(contract_name)
      end

      def save
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

module VaultTree
  module CLI
    class SettingsFile

      def default_settings_path #Override this method in test context
        File.expand_path('~/projects/vault-tree/vault-tree/spec/support/cli/.vt')
      end

      def delete_empty_settings_file
        File.delete(empty_settings_path) if File.exists?(empty_settings_path)
      end

      def empty_settings_path
        PathHelpers.empty_settings_file
      end

      def write_empty_settings_file
        File.open(empty_settings_path, 'w') {|f| f.write(empty_contents) } 
      end

      def empty_contents
%Q[
---
:password: 'EMPTY_SETTINGS_PASSWORD'
:contracts: 
:active:
:data: 
]
      end
    end
  end
end

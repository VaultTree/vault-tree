module VaultTree
  module CLI
    class SettingsFile

      def user_settings_path #Override this method in test context
        File.expand_path('~/.vt')
      end

      def delete_test_settings_file
        File.delete(test_settings_path) if File.exists?(test_settings_path)
      end

      def test_settings_path
        PathHelpers.test_settings_file
      end

      def write_empty_settings_file
        File.open(test_settings_path, 'w') {|f| f.write(empty_contents) } 
      end

      def write_default_settings_file
        File.open(test_settings_path, 'w') {|f| f.write(default_contents) } 
      end

      def default_contents
        File.read PathHelpers.default_settings_fixture
      end

      def empty_contents
        File.read PathHelpers.empty_settings_fixture
      end
    end
  end
end

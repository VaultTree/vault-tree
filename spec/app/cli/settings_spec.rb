require 'spec_helper'

module VaultTree
  module CLI
    describe 'Settings' do

      context 'for data paths' do
        before :each do
          settings_file = SettingsFile.new
          settings_file.write_empty_settings_file
          @empty_settings_path = settings_file.test_settings_path
        end

        describe '#list_data' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
          end

          it 'returns an empty array if there are no data files to list' do
            @settings.list_data.should == []
          end

          it 'returns an array of names for each registered data file' do
            @settings.add_data('simple_data', '~/path/to/data')
            @settings.list_data[0].should == 'simple_data'
          end
        end

        describe '#add_data' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
          end

          it 'returns true' do
            @settings.add_data('simple_data', '~/path/to/data').should be true
          end

          it 'the name and path has been properly added' do
            @settings.add_data('simple_data', '~/path/to/data')
            @settings.contents[:data].keys.include?('simple_data').should be true
            @settings.contents[:data]['simple_data'].should == '~/path/to/data'
          end
        end


        describe '#rm_data' do

          before :each do
            @settings = Settings.new(@empty_settings_path)
            @settings.add_data('simple_data', '~/path/to/data')
          end

          it 'returns true' do
            @settings.rm_data('simple_data').should be true
          end

          it 'a name and path has been properly removed' do
            @settings.rm_data('simple_data')
            @settings.list_data.should == []
          end

        end
      end

      context 'for contract paths' do
        before :each do
          settings_file = SettingsFile.new
          settings_file.write_empty_settings_file
          @empty_settings_path = settings_file.test_settings_path
        end

        describe '#settings_file' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
          end

          it 'returns a path as a string' do
            @settings.settings_file.should be_an_instance_of(String)
          end

          it 'a file exists at the location' do
            File.exists?(@settings.settings_file).should be true
          end
        end

        describe '#contents' do
          it 'returns a hash of the settings file' do
            @settings = Settings.new(@empty_settings_path)
            @settings.contents.should be_an_instance_of(Hash)
          end
        end

        describe '#save' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
          end

          it 'returns true' do
            @settings.save.should be true
          end

          it 'the file is properly saved' do
            File.delete(@empty_settings_path)
            @settings.save
            YAML.load_file(@empty_settings_path).should == @settings.contents
          end
        end

        describe '#raw_contents' do
          it 'returns a string' do
            @settings = Settings.new(@empty_settings_path)
            @settings.raw_contents.should be_an_instance_of(String)
          end
        end

        describe '#add_contract' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
          end

          it 'returns true' do
            @settings.add_contract('first_contract', '~/path/to/contract').should be true
          end

          it 'a name and path has been properly added' do
            @settings.add_contract('first_contract', '~/path/to/contract')
            @settings.contents[:contracts].keys.include?('first_contract').should be true
            @settings.contents[:contracts]['first_contract'].should == '~/path/to/contract'
          end

          it 'when there are no registered contacts the newly added contract is active' do
            @settings.add_contract('first_contract', '~/path/to/contract')
            @settings.active_contract?('first_contract').should be true
          end

        end

        describe '#list_contracts' do

          before :each do
            @settings = Settings.new(@empty_settings_path)
          end

          it 'returns an empty array if there are no contracts to list' do
            @settings.list_contracts.should == []
          end

          it 'returns an array of names that contains the names of registered contracts' do
            @settings.add_contract('first_contract', '~/path/to/contract')
            @settings.list_contracts[0].should == 'first_contract'
          end
        end

        describe '#rm_contract' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
            @settings.add_contract('first_contract', '~/path/to/contract')
          end

          it 'returns true' do
            @settings.rm_contract('first_contract').should be true
          end

          it 'a name an path has been properly removed' do
            @settings.rm_contract('first_contract')
            @settings.list_contracts.should == []
          end
        end

        describe '#activate_contract' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
            @settings.add_contract('first_contract', '~/path/to/contract')
          end

          it 'returns true' do
            @settings.activate_contract('first_contract').should be true
          end

          it 'properly sets the new active contract' do
            @settings.activate_contract('first_contract')
            @settings.contents[:active].should == 'first_contract'
          end
        end

        describe '#active_contract?' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
            @settings.add_contract('first_contract', '~/path/to/contract')
            @settings.add_contract('second_contract', '~/path/to/contract')
            @settings.activate_contract('first_contract')
          end

          it 'returns true if the given contract is active' do
            @settings.active_contract?('first_contract').should be true
          end

          it 'returns false if the given contract is not active' do
            @settings.active_contract?('second_contract').should be false
          end
        end

        describe '#active_contract_path' do
          before :each do
            @settings = Settings.new(@empty_settings_path)
            @settings.add_contract('second_contract', '~/path/to/contract')
            @settings.add_contract('first_contract', '~/path/to/contract')
            @settings.activate_contract('first_contract')
          end

          it 'returns a string' do
            @settings.active_contract_path.should be_an_instance_of(String)
          end

          it 'returns the expected path' do
            @settings.active_contract_path.should == '~/path/to/contract'
          end
        end
      end
    end
  end
end

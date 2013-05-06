require 'spec_helper'
module LockSmith
  describe 'SymmetricVault' do

    describe '#lock' do
      before :each do
        @symmetric_vault = SymmetricVault.new
        symmetric_key_json = SymmetricKey.new(vault_id: @symmetric_vault.id).as_json
        @symmetric_vault.add_object(symmetric_key_json)
      end

      it 'the json vault value is still a String' do
        @symmetric_vault.lock
        @symmetric_vault.as_json.kind_of?(String).should == true
      end
    end

    describe '#unlock' do
      it 'returns the vault string' do
        @symmetric_vault = SymmetricVault.new
        symmetric_key_json = SymmetricKey.new(vault_id: @symmetric_vault.id).as_json
        @symmetric_vault.add_object(symmetric_key_json)
        @symmetric_vault.lock
        @symmetric_vault.unlock.kind_of?(String).should == true#
      end

      it 'the unlocked vault contains has correct json' do
        @symmetric_vault = SymmetricVault.new
        symmetric_key_json = SymmetricKey.new(vault_id: @symmetric_vault.id).as_json
        @symmetric_vault.add_object(symmetric_key_json)
        expected_json = @symmetric_vault.as_json
        @symmetric_vault.lock
        @symmetric_vault.unlock
        @symmetric_vault.as_json.should == expected_json
      end
    end

    describe '#lock_down(key)' do
      before :each do
        @symmetric_vault = SymmetricVault.new(Fixtures.test_vault_contents)
        @valid_vault_key = SymmetricKey.new(vault_id: @symmetric_vault.id)
      end

      it 'returns the encrytped contents if the lock_down was sucessful' do
        contents = @symmetric_vault.lock_down (@valid_vault_key)
        contents.kind_of?(String).should == true
      end
    end

    describe '#open_up(key)' do
      before :each do
        @symmetric_vault = SymmetricVault.new(Fixtures.test_vault_contents)
        @valid_vault_key = SymmetricKey.new(vault_id: @symmetric_vault.id)
        @invalid_vault_key = SymmetricKey.new(vault_id: @symmetric_vault.id, rbnacl_key: 'INVALID_SECRET_KEY')
      end

      it 'returns the contents if the open_up was sucessful' do
        @symmetric_vault.lock_down(@valid_vault_key)
        contents = @symmetric_vault.open_up(@valid_vault_key)
        ActiveSupport::JSON.decode(contents)["class"].should == Fixtures.test_vault_class
      end

      it 'returns nil if the open_up attempt was unsucessful' do
        @symmetric_vault.lock_down(@valid_vault_key)
        contents = @symmetric_vault.open_up(@invalid_vault_key)
        contents.nil?.should == true
      end
    end
  end
end

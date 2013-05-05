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

  end
end

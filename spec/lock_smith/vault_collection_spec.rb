require 'spec_helper'

module LockSmith
  describe 'VaultCollection' do
    before :all do
      @valid_collection = Fixtures.valid_vault_collection
      @valid_vault_id = Fixtures.valid_vault_id
      @invalid_vault_id = Fixtures.invalid_vault_id
    end

    describe '#[]' do
      it 'returns a Vault when given a valid vault id' do
        collection = VaultCollection.new(@valid_collection)
        collection[@valid_vault_id].should be_an_instance_of(Vault)
      end

      it 'returns the Null Vault when given an invalid vault id' do
        collection = VaultCollection.new(@valid_collection)
        collection[@invalid_vault_id].should be_an_instance_of(NullVault)
      end
    end
  end
end

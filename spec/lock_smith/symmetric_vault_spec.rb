require 'spec_helper'
module LockSmith
  describe 'SymmetricVault' do

    describe '#lock' do
      before :each do
        @symmetric_vault = SymmetricVault.new
        symmetric_key_json = SymmetricKey.new(vault_id: @symmetric_vault.id).as_json
        @symmetric_vault.add_object(symmetric_key_json)
      end

      it 'encrypts its string' do
        @symmetric_vault.lock
        puts @symmetric_vault.as_json
      end
    end
  end
end

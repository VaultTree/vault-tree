require 'spec_helper'
module VaultTree 
  describe 'Contract' do
    describe '#enforce' do
      before :each do
        @encrypted_json = Fixtures.one_two_three_encrypted
        @contract_password = 'VAULT_KEY_1'
        @contract = Contract.new(@encrypted_json, contract_password: @contract_password)
      end

      it 'writes the decryped contents to log' do
        @contract.enforce
        pending
        puts ActiveSupport::JSON.decode(@contract.log)
      end
    end
  end
end


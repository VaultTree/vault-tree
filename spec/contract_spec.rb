require 'spec_helper'
module VaultTree 
  describe 'Contract' do
    describe '#enforce' do
      before :each do
        @encrypted_json = Fixtures.one_two_three_encrypted
        @contract_key = 'VAULT_KEY_1'
        @contract = Contract.new(@encrypted_json, contract_key: @contract_key)
      end

      it 'writes the decryped contents to log' do
        @contract.enforce
        pending
        puts ActiveSupport::JSON.decode(@contract.log)
      end
    end
  end
end

module VaultTree
  class Contract
    attr_reader :string

    def initialize(json, opts = {contract_key: nil})
      @contract_key = opts[:contract_key] 
      @string = json
      @log = ''
    end

    def enforce
      puts "Enforcing with this json: #{string}"
    end

    def log
      @log
    end

    private

    def vault_collection
      @vault_collection ||= LockSmith::VaultCollection.new(string)
    end

  end
end

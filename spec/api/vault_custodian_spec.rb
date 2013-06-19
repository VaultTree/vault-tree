require 'spec_helper'

module VaultTree
  module V1
    describe 'VaultCustodian' do
      describe '#fill_vault' do

        before :all do
          @contract = FactoryGirl.create(:contract_with_empty_vault).as_json
        end

        before :each do
          @expected_contents = 'CONGRATULATIONS YOU HAVE FILLED THE VAULT.'
          @label = "[1]"
          opts = {vault_label: @label, contents: @expected_contents}
          @returned_contract = VaultCustodian.new(@contract, opts).fill_vault
          @returned_contract_hash = Support::JSON.decode(@returned_contract)
          @content = @returned_contract_hash["vaults"].select{|v| v["label"] == @label}.first["content"]
        end

        it 'the vault contents have been properly set' do
          @content.should == @expected_contents
        end
      end

      describe '#lock_vault' do
        it 'the vault contents are now an encrypted string' do
          pending
        end

        it 'decrypting the vault value returns the original contents' do
          pending
        end
      end

      describe '#sign_vault' do
        it 'the vaults signed_vault_content field is set with a signature' do
          pending
        end

        it 'the signature validates against the custodians verification key' do
          pending
        end
      end
    end
  end
end

require 'spec_helper'

module VaultTree
  module V1
    describe 'VaultCustodian' do
      describe '#fill_vault' do

        before :all do
          @contract = FactoryGirl.create(:contract_with_empty_vault).as_json
        end

        before :each do
          @expected_content = 'CONGRATULATIONS YOU HAVE FILLED THE VAULT.'
          @label = "[1]"
        end

        before :each do
          opts = {vault_label: @label, content: @expected_content}
          @returned_contract = VaultCustodian.new(@contract, opts).fill_vault
          @desr_contract = Support::DeserializedContract.new(@returned_contract)
          @content = @desr_contract.vault_content(@label)
        end

        it 'the vault content has been properly set' do
          @content.should == @expected_content
        end
      end

      describe '#lock_vault' do
        before :all do
          @contract = FactoryGirl.create(:contract_with_filled_vault).as_json
        end

        before :each do
          @expected_content = 'CONGRATULATIONS YOU HAVE FILLED THE VAULT.'
          @label = "[1]"
        end

        before :each do
          @cipher = LockSmith::SymmetricCipher.new
          @vault_key = @cipher.generate_key
          opts = {vault_label: @label, vault_key: @vault_key}
          @returned_contract = VaultCustodian.new(@contract, opts).lock_vault
          @desr_contract = Support::DeserializedContract.new(@returned_contract)
          @encryped_content = @desr_contract.vault_content(@label)
        end

        it 'the vault content is now an encrypted string' do
          @encryped_content.should be_an_instance_of(String)
        end

        it 'decrypting the vault value returns the original content' do
          @cipher.decrypt(cipher_text: @encryped_content, key: @vault_key).should == @expected_content
        end
      end

      describe '#sign_vault' do

        before :each do
          @contract = FactoryGirl.create(:contract_with_locked_vault).as_json
          @signing_key = LockSmith::SigningKeyPair.new().signing_key
        end

        before :each do
          @label = "[1]"
          opts = {vault_label: @label, custodian_signing_key: @signing_key}
          @returned_contract = VaultCustodian.new(@contract, opts).sign_vault
          @desr_contract = Support::DeserializedContract.new(@returned_contract)
        end

        it 'the vaults signed_vault_content field is set with a signature' do
          @desr_contract.signed_vault_content(vault_label: @label).should be_an_instance_of(String)
        end

        it 'the signature is none empty' do
          @desr_contract.signed_vault_content(vault_label: @label).empty?.should be false
        end
      end
    end
  end
end

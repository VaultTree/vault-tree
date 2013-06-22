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
          @returned_contract_hash = Support::JSON.decode(@returned_contract)
          @content = @returned_contract_hash["vaults"].select{|v| v["label"] == @label}.first["content"]
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
          @returned_contract_hash = Support::JSON.decode(@returned_contract)
          @encryped_content = @returned_contract_hash["vaults"].select{|v| v["label"] == @label}.first["content"] 
        end

        it 'the vault content is now an encrypted string' do
          @encryped_content.should be_an_instance_of(String)
        end

        it 'decrypting the vault value returns the original content' do
          @cipher.decrypt(cipher_text: @encryped_content, key: @vault_key).should == @expected_content
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

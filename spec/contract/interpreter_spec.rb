require 'spec_helper'

module VaultTree
  module V3
    describe 'Interpreter' do

      before :all do
        @alice = User.new(user_id: 'alice', master_passphrase: 'ALICE_SECURE_PASS', shared_contract_secret: 'ALICE_AND_BOB')
      end

      describe '#close_vault_path' do
        before :each do
          @contract = FactoryGirl.build(:blank_one_two_three)
        end

        context 'for alice' do
          before :each do
            @interpreter = Interpreter.new
          end

          it 'can close the public encryption key vault' do
            @contract = @interpreter.close_vault_path(vault_id: 'alice_public_encryption_key', contract: @contract, user: @alice)
            @contract.vault_closed?('alice_public_encryption_key').should be true
          end

          it 'can close contract shared secret vault' do
            @contract = @interpreter.close_vault_path(vault_id: 'alice_shared_contract_secret', contract: @contract, user: @alice)
            @contract.vault_closed?('alice_shared_contract_secret').should be true
          end

          it 'can close decryption key vault' do
            @contract = @interpreter.close_vault_path(vault_id: 'alice_decryption_key', contract: @contract, user: @alice)
            @contract.vault_closed?('alice_decryption_key').should be true
          end
        end

        context 'for bob' do
          it 'pends' do
            pending 'Not Implemented'
          end
        end
      end

      describe '#retrieve_contents' do
        context 'for alice' do
          before :each do
            @contract = FactoryGirl.build(:blank_one_two_three)
            @interpreter = Interpreter.new
          end

          it 'can retrieve her shared contract secret' do
            @contract = @interpreter.close_vault_path(vault_id: 'alice_shared_contract_secret', contract: @contract, user: @alice)
            @contents = @interpreter.retrieve_contents(vault_id: 'alice_shared_contract_secret', contract: @contract, user: @alice)
            @contents.should == @alice.shared_contract_secret
          end

          it 'can retrieve her decryption_key' do
            @contract = @interpreter.close_vault_path(vault_id: 'alice_decryption_key', contract: @contract, user: @alice)
            @contents = @interpreter.retrieve_contents(vault_id: 'alice_decryption_key', contract: @contract, user: @alice)
            @contents.should == @alice.decryption_key
          end

          it 'can retrieve her own public encryption key' do
            @contract = @interpreter.close_vault_path(vault_id: 'alice_public_encryption_key', contract: @contract, user: @alice)
            @contents = @interpreter.retrieve_contents(vault_id: 'alice_public_encryption_key', contract: @contract, user: @alice)
            @contents.should == @alice.public_encryption_key
          end
        end
      end

    end
  end
end

require 'spec_helper'

module VaultTree
  module V3
    describe 'Interpreter' do

      before :all do
        @alice = User.new(master_passphrase: 'ALICE_SECURE_PASS')
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

          it 'can close decryption key vault' do
            @contract = @interpreter.close_vault_path(vault_id: 'alice_decryption_key', contract: @contract, user: @alice)
            @contract.vault_closed?('alice_decryption_key').should be true
          end
        end
      end

      describe '#retrieve_contents' do
        context 'for alice' do
          before :each do
            @contract = FactoryGirl.build(:blank_one_two_three)
            @interpreter = Interpreter.new
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

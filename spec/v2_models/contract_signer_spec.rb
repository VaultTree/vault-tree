require 'spec_helper'

module VaultTree
  module V2
    describe 'ContractSigner' do

      describe '#sign' do

        it 'address signature has been populated' do
          pending
          @contract = ContractSigner.new(contract: @signing_key_and_public_data).sign
          @contract.signature_present?('alice','address')
        end

        it 'verification_key signature has been populated' do
          pending
          @contract = ContractSigner.new(contract: @signing_key_and_public_data).sign
          @contract.signature_present?('alice','verification_key')
        end

        it 'an exception is thrown if there is more than 1 private signing key found' do
          pending
          @contract = ContractModifier.new(contract: @signing_key_and_public_data, changes: @bob_private_data).sign
          expect{}.to raise_error
        end
      end

    end
  end
end

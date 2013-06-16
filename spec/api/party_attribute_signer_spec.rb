require 'spec_helper'

module VaultTree
  module V1
    describe 'PartyAttributeSigner' do
      describe '#run' do
        context 'valid input' do
          context 'for verification_key' do
            it 'returns the contract as a json string' do
              pending
            end

            it 'proper digital signature is present in the signing block'  do
              pending
            end
          end

          context 'for party_label' do
            it 'proper digital signature is present in the signing block'  do
              pending
            end
          end
        end

        context 'invalid input' do
          context 'for non_existant_attribute' do
            it 'it raises an unsuppored attr exception' do
              pending
            end
          end
        end
      end
    end
  end
end

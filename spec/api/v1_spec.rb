require 'spec_helper'

module VaultTree
  module V1
    describe '.set_public_keys' do
      context 'for valid input options' do
        it 'the signature_key is properly set' do
          pending 'Not Implemented'
        end

        it 'the encryption key is properly set' do
          pending 'Not Implemented'
        end
      end

      context 'for invalid input option' do
        describe 'invalid signature for signature_verification_key ' do
        end

        describe 'invalid signature for public_encryption_key ' do
        end
      end
    end

    describe '.certify_contract' do
      it 'build as we go' do
        pending 'Not Implemented'
      end
    end

  end
end

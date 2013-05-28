require 'spec_helper'

module VaultTree
  describe '.set_public_keys' do
    before :all do
    end

    context 'for valid input options' do

      before :each do
        pending 'PICK UP HERE. BASIC INTIGRATION SPEC FOR SET PUBLIC KEY.'
        @in_contract = 
        @in_hash = @decoder.decode(@in_contract)
        @out_contract = V1.set_public_keys(@in_contract,@opts)
        @out_hash = @decoder.decode(@out_contract)
      end

      it 'the verification_key is properly set' do
        @out_hash['parties'][1]['verification_key'].should == @opts[:verification_key]
      end

      it 'the public_encryption_key is properly set' do
        pending 'Not Implemented'
      end
    end

    context 'for invalid input option' do
      it 'signing key is not provided' do
        pending
      end
    end
  end

  describe '.certify_contract' do
    context 'for invalid input option' do
      describe 'invalid signature for signature_verification_key ' do
        it 'build as we go' do
          pending 'Not Implemented'
        end
      end

      describe 'invalid signature for public_encryption_key ' do
        it 'build as we go' do
          pending 'Not Implemented'
        end
      end
    end
  end
end

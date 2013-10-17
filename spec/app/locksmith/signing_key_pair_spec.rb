require 'spec_helper'
module VaultTree
  module LockSmith

    describe 'SigningKeyPair' do
      describe '#new' do

        before :each do
          @signing_key_pair = SigningKeyPair.new
        end

        it 'generates a new private key' do
          @signing_key_pair.signing_key.should be_an_instance_of(String)
        end

        it 'generates a new public key' do
          @signing_key_pair.verify_key.should be_an_instance_of(String)
        end
      end
    end
  end
end

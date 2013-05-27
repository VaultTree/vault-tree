require 'spec_helper'
module VaultTree
  module LockSmith

    describe 'KeyPair' do
      describe '#new' do

        before :each do
          @key_pair = KeyPair.new
        end

        it 'generates a new private key' do
          @key_pair.private_key.should be_an_instance_of(PrivateKey)
        end

        it 'generates a new public key' do
          @key_pair.public_key.should be_an_instance_of(PublicKey)
        end

        it 'private key as a 64 character string string' do
          @key_pair.private_key.to_s.length.should == 64
        end

        it 'private key as a 64 character string string' do
          @key_pair.public_key.to_s.length.should == 64
        end
      end

      describe '#sign' do
        before :all do
          @msg = 'Hello World!'
          @key_pair = KeyPair.new
          @private_key = @key_pair.private_key
          @public_key = @key_pair.public_key
        end

        it 'can sign a message with the private key' do
          pending
          sig = @private_key.sign(@msg)
          @public_key.vaild_signature?({signature: sig, message: @msg}).should be true
        end
      end

    end
  end
end

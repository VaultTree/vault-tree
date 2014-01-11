require 'spec_helper'

module VaultTree
  module LockSmith
    describe SymmetricCipher do

      before :each do
        @cipher = SymmetricCipher.new
        @key = 'encryption_key'
        @plain_text = 'Secret Message'
      end

      describe '#encrypt | #decrypt' do
        it 'encrypt and decrypt a simple message' do
          cipher_text = @cipher.encrypt(plain_text: @plain_text, key: @key)
          @cipher.decrypt(cipher_text: cipher_text, key: @key).should == @plain_text
        end
      end
    end
  end
end

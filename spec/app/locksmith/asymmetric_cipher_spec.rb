require 'spec_helper'

module VaultTree
  describe 'AsymmetricCipher' do

    before :each do
      @alice = User.new 
      @bob = User.new 
      alice_key_pair = LockSmith::EncryptionKeyPair.new
      @alice_priv_key = alice_key_pair.generate_private_key
      @alice_pub_key = alice_key_pair.public_key(@alice_priv_key)
      bob_key_pair = LockSmith::EncryptionKeyPair.new
      @bob_priv_key = bob_key_pair.generate_private_key
      @bob_pub_key = bob_key_pair.public_key(@bob_priv_key)
      @message = 'ENCRYPT_ME!'
      @asymmetric_cipher = LockSmith::AsymmetricCipher.new
    end

    describe '#encrypt | #decrypt' do
      it 'Bob can encrypt with alice pub key and Alice can decrypt' do
        cipher_text = @asymmetric_cipher.encrypt(public_key: @alice_pub_key, secret_key: @bob_priv_key, plain_text: @message)
        plain_text = @asymmetric_cipher.decrypt(public_key: @bob_pub_key, secret_key: @alice_priv_key, cipher_text: cipher_text)
        plain_text.should == @message
      end
    end
  end
end

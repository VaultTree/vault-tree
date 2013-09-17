require 'spec_helper'

module VaultTree
  describe 'AsymmetricCipher' do

    before :each do
      @alice = User.new 
      @bob = User.new 
      @alice_priv_key = @alice.decryption_key
      @alice_pub_key = @alice.public_encryption_key
      @bob_priv_key = @bob.decryption_key
      @bob_pub_key = @bob.public_encryption_key
      @message = 'ENCRYPT_ME!'
      @asymmetric_cipher = LockSmith::AsymmetricCipher.new
    end

    describe '#encrypt | #decrypt' do
      it 'Bob can encrypt with alice pub key and Alice can decrypt' do
        cipher_text = @asymmetric_cipher.encrypt(@alice_pub_key, @bob_priv_key, @message)
        plain_text = @asymmetric_cipher.decrypt(@bob_pub_key, @alice_priv_key, cipher_text)
        plain_text.should == @message
      end
    end
  end
end

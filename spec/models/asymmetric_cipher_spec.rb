require 'spec_helper'

module VaultTree
  describe 'AsymmetricCipher' do

    before :each do
      @alice_priv_key = Crypto::PrivateKey.generate
      @alice_pub_key = @alice_priv_key.public_key
      @bob_priv_key = Crypto::PrivateKey.generate
      @bob_pub_key = @bob_priv_key.public_key
      @message = 'ENCRYPT_ME!'
      @asymmetric_cipher = LockSmith::AsymmetricCipher.new
    end

    describe '#encrypt | #decrypt' do
      it 'Bob can encrypt with alice pub key and Alice can decrypt' do
        cipher_text = @asymmetric_cipher.encrypt(@alice_pub_key.to_s(:base64), @bob_priv_key.to_s(:base64), @message)
        plain_text = @asymmetric_cipher.decrypt(@bob_pub_key.to_s(:base64), @alice_priv_key.to_s(:base64), cipher_text)
        plain_text.should == @message
      end
    end
  end
end

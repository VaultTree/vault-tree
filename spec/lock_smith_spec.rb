require 'rspec'

require_relative '../lib/vault-tree/lock_smith'

module VaultTree
  describe LockSmith do

    describe '#symmetric_encrypt | #symmetric_decrypt' do
      it 'encrypt and decrypt a simple message' do
        secret_key = LockSmith.new(message: 'my_secret_key').secure_hash
        cipher_text = LockSmith.new(message: 'Secret Message', secret_key: secret_key).symmetric_encrypt
        recovered_msg = LockSmith.new(cipher_text: cipher_text, secret_key: secret_key).symmetric_decrypt
        recovered_msg.should == 'Secret Message'
      end
    end

    describe '#asymmetric_encrypt  | #asymmetric_decrypt' do
      it 'bob can encrypt with alice pub key and Alice can decrypt' do
        alice_priv_key = LockSmith.new().generate_private_key
        alice_pub_key = LockSmith.new(private_key: alice_priv_key).generate_public_key
        alice_pub_key = LockSmith.new(private_key: alice_priv_key).generate_public_key
        bob_priv_key = LockSmith.new().generate_private_key
        bob_pub_key = LockSmith.new(private_key: bob_priv_key).generate_public_key
        cipher_text = LockSmith.new(message: 'Secret Message', public_key: alice_pub_key, private_key: bob_priv_key).asymmetric_encrypt
        bob_pub_key = LockSmith.new(private_key: bob_priv_key).generate_public_key
        recovered_msg = LockSmith.new(cipher_text: cipher_text, public_key: bob_pub_key, private_key: alice_priv_key).asymmetric_decrypt
        recovered_msg.should == 'Secret Message'
      end
    end

    describe '#sign_message | #verify_message' do
      it 'sign and verify a message' do
        msg = 'My Message to Sign!'
        sk = LockSmith.new().generate_signing_key
        vk = LockSmith.new(signing_key: sk).generate_verify_key
        sig = LockSmith.new(signing_key: sk, message: msg).sign_message
        LockSmith.new(verify_key: vk, message: msg, signature: sig).verify_message.should be true
      end
    end

  end
end

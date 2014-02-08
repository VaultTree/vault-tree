require 'rspec'
RSpec.configure{ |config| config.color_enabled = true }

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

    describe '#split_random_secret' do
      it 'returns an array with the correct number strings' do
        secret_shares = LockSmith.new(outstanding_secret_shares: 5, secret_recovery_threshold: 3).split_random_secret
        secret_shares.should be_an_instance_of(Array)
        secret_shares.first.should be_an_instance_of(String)
        secret_shares.length.should == 5
      end
    end

    describe '#split_random_secret | #assemble_shamir_key' do
      context 'with 3 out of 5 secrets' do
        it 'can generate and recover the split secret' do
          secret_shares = LockSmith.new(outstanding_secret_shares: 5, secret_recovery_threshold: 3).split_random_secret
          first_three = secret_shares[0..2]
          last_three = secret_shares[2..4]
          recovered_from_first_three = LockSmith.new(secret_shares: first_three).assemble_shamir_key
          recovered_from_last_three = LockSmith.new(secret_shares: last_three).assemble_shamir_key
          recovered_from_first_three.should_not be nil
          recovered_from_first_three.should == recovered_from_last_three
        end
      end
    end

  end
end

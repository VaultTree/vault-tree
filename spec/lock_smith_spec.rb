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

    describe '#split_secret | #combine_secret_shares' do

      context 'with 3 out of 5 secrets' do
        it 'recovers the shared secret' do
          pending
          secret_key = LockSmith.new().generate_secret_key
          secret_shares = LockSmith.new(message: secret_key, outstanding_secret_shares: 5, secret_recovery_threshold: 3).split_secret
          combined_secret = LockSmith.new(message: secret_key, secret_shares: secret_shares).combine_secret_shares
          combined_secret.should == secret_key
        end
      end

      context 'with 5 out of 5 secrets' do
        it 'recovers the shared secret' do
          pending
        end
      end

      context 'with 2 out of 2 secrets' do
        it 'recovers the shared secret' do
          pending
        end
      end

      context 'in exceptional situations' do

        it 'throws an exception on init if one of the shares is not a string' do
          pending
          s = SecretSharing::Shamir.new(5,3)
          s.create_random_secret
          @established_secret = s.secret.to_s
          @expected_digest = LockSmith.new(message: @established_secret).secure_hash
          @key_shares = s.shares[0..2].map{|s| s.to_s}

          # Replace the last string with just an object
          @key_shares[2] = Object.new
          expect{AssembledShamirKey.new(key_shares: @key_shares)}.to raise_error(TypeError)
        end

        it 'throws an exception if the key shares are nil' do
          pending
          @key_shares = nil
          expect{AssembledShamirKey.new(key_shares: @key_shares)}.to raise_error(TypeError)
        end
      end
    end

  end
end

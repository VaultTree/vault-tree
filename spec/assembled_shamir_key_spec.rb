require 'rspec'
RSpec.configure{ |config| config.color_enabled = true }
require_relative '../lib/vault-tree/lock_smith/assembled_shamir_key'

module VaultTree
  describe AssembledShamirKey do

    describe '#assemble' do

      context 'with 3 out of 5 secrets' do
        before :each do
          s = SecretSharing::Shamir.new(5,3)
          s.create_random_secret
          @established_secret = s.secret.to_s
          @expected_digest = LockSmith.new(message: @established_secret).secure_hash
          @key_shares = s.shares[0..2].map{|s| s.to_s}
          @assembled_key = AssembledShamirKey.new(key_shares: @key_shares)
        end

        it 'recovers a hash of the shared secret' do
          @assembled_key.assemble.should == @expected_digest
        end
      end

      context 'with 5 out of 5 secrets' do
        before :each do
          s = SecretSharing::Shamir.new(5,5)
          s.create_random_secret
          @established_secret = s.secret.to_s
          @expected_digest = LockSmith.new(message: @established_secret).secure_hash
          @key_shares = s.shares[0..4].map{|s| s.to_s}
          @assembled_key = AssembledShamirKey.new(key_shares: @key_shares)
        end

        it 'recovers a hash of the shared secret' do
          @assembled_key.assemble.should == @expected_digest
        end
      end

      context 'with 2 out of 2 secrets' do
        before :each do
          s = SecretSharing::Shamir.new(2,2)
          s.create_random_secret
          @established_secret = s.secret.to_s
          @expected_digest = LockSmith.new(message: @established_secret).secure_hash
          @key_shares = s.shares[0..1].map{|s| s.to_s}
          @assembled_key = AssembledShamirKey.new(key_shares: @key_shares)
        end

        it 'recovers a hash of the shared secret' do
          @assembled_key.assemble.should == @expected_digest
        end
      end

      context 'in exceptional situations' do

        it 'throws an exception on init if one of the shares is not a string' do
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
          @key_shares = nil
          expect{AssembledShamirKey.new(key_shares: @key_shares)}.to raise_error(TypeError)
        end
      end

    end
  end
end

require 'spec_helper'

module VaultTree
  module LockSmith
    describe GeneratedShamirKey do

      describe '#generate | #assemble' do

        context 'with 3 out of 5 secrets' do
          it 'recovers a hash of the shared secret' do
            generated_key = GeneratedShamirKey.new(outstanding_shares: 5, recovery_threshold: 3)
            expected_digest = generated_key.key
            key_shares = generated_key.shares
            assembled_key = AssembledShamirKey.new(key_shares: key_shares)
            assembled_key.assemble.should == expected_digest
          end

          it 'recovers a hash of the shared secret when the shares are requested before the key' do
            generated_key = GeneratedShamirKey.new(outstanding_shares: 5, recovery_threshold: 3)
            key_shares = generated_key.shares
            expected_digest = generated_key.key
            assembled_key = AssembledShamirKey.new(key_shares: key_shares)
            assembled_key.assemble.should == expected_digest
          end
        end

        context 'with 5 out of 5 secrets' do
          it 'recovers a hash of the shared secret' do
            generated_key = GeneratedShamirKey.new(outstanding_shares: 5, recovery_threshold: 5)
            expected_digest = generated_key.key
            key_shares = generated_key.shares
            assembled_key = AssembledShamirKey.new(key_shares: key_shares)
            assembled_key.assemble.should == expected_digest
          end
        end

        context 'with 2 out of 2 secrets' do
          it 'recovers a hash of the shared secret' do
            generated_key = GeneratedShamirKey.new(outstanding_shares: 2, recovery_threshold: 2)
            expected_digest = generated_key.key
            key_shares = generated_key.shares
            assembled_key = AssembledShamirKey.new(key_shares: key_shares)
            assembled_key.assemble.should == expected_digest
          end
        end

      end
    end
  end
end

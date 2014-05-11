require 'rspec'
require 'JSON'
RSpec.configure{ |config| config.color_enabled = true }
require_relative '../lib/vault-tree/lock_smith/shamir_key_shares'

module VaultTree
  module Crypto
    describe ShamirKeyShares do
      describe '#generate' do
        it 'generates a json object with the correct number of shares' do
          @shares = ShamirKeyShares.new(outstanding_shares: 5, recovery_threshold: 3).generate
          @shares.should be_an_instance_of(String)
          JSON.parse(@shares).should be_an_instance_of(Hash)
          JSON.parse(@shares).has_key?('1').should be true
          JSON.parse(@shares).has_key?('5').should be true
        end

        it 'raises and error when the oustanding shares are less than 2' do
          expect{ShamirKeyShares.new(outstanding_shares: 1, recovery_threshold: 1).generate}.to raise_error
        end

        it 'raises and error when the share threshold is greater than the outstanding shares' do
          expect{ShamirKeyShares.new(outstanding_shares: 5, recovery_threshold: 6).generate}.to raise_error
        end
      end
    end
  end
end

require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/vault-tree'

module VaultTree
  module Notifications
    describe 'Printing a notification' do
      it 'Outputs message nicely to standard out' do
        # Uncomment these to inspect the message formating
        #
        # FailedUnlockAttempt.new(vault_id: 'a_specific_vault', unlocking_key: 'EXTERNAL_DATA').notify
      end
    end

    describe 'printing a notification' do
      it 'prints to standard out' do
        FailedUnlockAttempt.new(
          vault_id: 'a_specific_vault',
          unlocking_key: 'EXTERNAL_DATA'
        ).respond_to?(:notify).must_equal(true)
      end
    end
  end
end

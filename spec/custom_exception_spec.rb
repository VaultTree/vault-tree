require 'rspec'
RSpec.configure{ |config| config.color_enabled = true }
require_relative '../lib/vault-tree'

module VaultTree
  module Exceptions
    describe 'Raising a Custom Exception' do

      def example_code
        begin
          raise 'Some Random Runtime Error'
        rescue => e
          raise FailedUnlockAttempt.new(e,
                                        vault_id: 'a_specific_vault',
                                        unlocking_key: 'EXTERNAL_DATA')
        end
      end

      it 'can catch an exception and reraise a custom exception' do
        expect{example_code}.to raise_error(FailedUnlockAttempt)
      end

      it 'Outputs message nicely to standard out' do
        begin
          example_code
        rescue
          STDOUT.write('Hopefully this looks good.')
        end
      end
    end

    describe 'Output of various custom exceptions' do

      it 'Failed Unlock Attempt' do
        begin
          raise 'Some Random Runtime Error'
        rescue => e
          begin
            raise FailedUnlockAttempt.new(e,
                                          vault_id: 'a_specific_vault',
                                          unlocking_key: 'EXTERNAL_DATA')
          rescue
          end
        end
      end

      it 'Empty Vault' do
        begin
          raise 'Some Random Runtime Error'
        rescue => e
          begin
            raise EmptyVault.new(e, vault_id: 'a_specific_vault')
          rescue
          end
        end
      end

      it 'Vault Does Not Exist' do
        begin
          raise 'Some Random Runtime Error'
        rescue => e
          begin
            raise VaultDoesNotExist.new(e, vault_id: 'some_none_existant_vault')
          rescue
          end
        end
      end



    end
  end
end

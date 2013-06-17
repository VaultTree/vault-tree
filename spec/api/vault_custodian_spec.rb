require 'spec_helper'

module VaultTree
  module V1
    describe 'VaultCustodian' do
      describe '#fill_vault' do
        it 'the vault contents have been properly set' do
          pending
        end
      end
      describe '#lock_vault' do
        it 'the vault contents are now an encrypted string' do
          pending
        end

        it 'decrypting the vault value returns the original contents' do
          pending
        end
      end

      describe '#sign_vault' do
        it 'the vaults signed_vault_content field is set with a signature' do
          pending
        end

        it 'the signature validates against the custodians verification key' do
          pending
        end
      end
    end
  end
end

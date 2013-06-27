require 'spec_helper'

module VaultTree
  module V1
    describe 'PartyAttributeValidator' do
      describe '#valid_signature?' do
        before :each do
          @contract = FactoryGirl.create(:contract_with_bob_cck).as_json
          @bob = AutoBots::Bob.new
          @alice = AutoBots::Alice.new
          @contract = @bob.write_public_attrs(@contract)
        end

        it 'returns true when bob properly signs his own contract consent key' do
          pending 'NOT YET IMPLEMENTED'
          contract = PartyAttributeSigner.new(@contract, party_label: "BOB",attribute: :contract_consent_key, private_signing_key: @bob.signing_key).run
          PartyAttributeValidator.new(contract, party_label: "BOB", attribute: :contract_consent_key).valid_sigature?.should be true
        end

        it 'returns false when alice signs bobs contract consent' do
          pending 'NOT YET IMPLEMENTED'
          contract = PartyAttributeSigner.new(@contract, party_label: "BOB", attribute: :contract_consent_key, private_signing_key: @alice.signing_key).run
          PartyAttributeValidator.new(party_label: "BOB", attribute: :contract_consent_key).valid_sigature?.should be false
        end

      end
    end
  end
end

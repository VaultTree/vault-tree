require 'spec_helper'

module VaultTree
  describe 'Party' do
    describe '#set_' do
      before :each do
        @contract = FactoryGirl.create(:contract)
        @party = @contract.parties.first
      end
    end

    describe '#create' do

      before(:each) do
        @party = FactoryGirl.create(:party)
      end

      it 'is properly created' do
        @party.should be_an_instance_of(Party)
      end
    end
  end
end

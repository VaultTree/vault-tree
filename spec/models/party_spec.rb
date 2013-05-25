require 'spec_helper'

describe 'Party' do
  describe '#create' do

    before(:each) do
      @party = FactoryGirl.create(:party)
    end

    it 'is properly created' do
      @party.should be_an_instance_of(VaultTree::Party)
    end
  end
end

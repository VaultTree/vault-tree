require 'spec_helper'
describe 'Vault' do
  describe '#create' do

    before(:each) do
      @vault = FactoryGirl.create(:vault)
    end

    it 'is properly created' do
      @vault.should be_an_instance_of(VaultTree::Vault)
    end

  end
end

require 'spec_helper'
describe 'Vault' do

  describe '#create' do
    before(:each) do
      @vault = FactoryGirl.create(:vault)
    end

    it 'has_many unlocking_conditions' do
      @vault.unlocking_conditions.length.should be > 1
    end

    it 'can access its unlocking conditions' do
      @vault.unlocking_conditions.first.should be_an_instance_of(VaultTree::UnlockingCondition)
    end
  end

  describe '#as_json' do
    before :all do
      @vault = FactoryGirl.create(:dummy_vault)
    end

    it 'has an id key' do
      ds = ActiveSupport::JSON.decode(@vault.as_json)
      ds.has_key?("id").should == true
    end

    it 'has a content key' do
      ds = ActiveSupport::JSON.decode(@vault.as_json)
      ds.has_key?("content").should == true
    end
  end
end

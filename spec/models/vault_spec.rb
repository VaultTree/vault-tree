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
end

require 'spec_helper'

describe 'Node' do
  describe '#create' do

    before(:each) do
      @node = FactoryGirl.create(:node)
    end

    it 'has_one vault' do
      @node.vault.should be_an_instance_of(VaultTree::Vault)
    end
  end
end

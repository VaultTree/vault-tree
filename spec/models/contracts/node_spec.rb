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

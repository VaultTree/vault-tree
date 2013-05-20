require 'spec_helper'
describe 'Enforcer' do
  describe '#create' do
    before(:each) do
      @enforcer = FactoryGirl.create(:dummy_enforcer)
    end

    describe 'belongs_to contract' do
      it 'can accesses its contract' do
        @enforcer.contract.should be_an_instance_of(VaultTree::Contract)
      end

      it 'can access nodes via the contract' do
        v = @enforcer.contract.nodes.first 
        v.should be_an_instance_of(VaultTree::Node)
      end
    end

    it 'has_many symmetric_vaults' do
      @enforcer.symmetric_vaults.length.should be > 1
    end

    it 'has_many asymmetric_vaults' do
      @enforcer.asymmetric_vaults.length.should be > 1
    end
  end
end

